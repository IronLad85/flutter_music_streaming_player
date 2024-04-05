import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_player/models/tracks.dart';
import 'package:music_player/services/firestore_service.dart';
import 'package:music_player/store/main_store.dart';

class FavoritesService {
  late MainStore mainStore;
  StreamSubscription? favoritesSubscription;

  FavoritesService._privateConstructor();
  String get userId => FirebaseAuth.instance.currentUser?.uid ?? 'anonymous';
  String get favoritesNode => 'user_favorites/$userId/tracks';
  static final instance = FavoritesService._privateConstructor();

  void setMainStoreReference(MainStore mainStoreReference) {
    mainStore = mainStoreReference;
  }

  Future<void> listenToFavoriteChanges() async {
    if (favoritesSubscription != null) {
      await favoritesSubscription?.cancel();
    }

    var firestore = FirestoreService.instance.firestore;
    favoritesSubscription =
        firestore.collection(favoritesNode).snapshots().listen((snapshot) {
      for (DocumentChange change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          mainStore.tracksStore.addTrackToFavorites(
            Track.fromJson(change.doc.data() as Map<String, dynamic>),
          );
        }

        if (change.type == DocumentChangeType.removed) {
          mainStore.tracksStore.removeTrackFromFavorites(change.doc.id);
        }
      }
    });
  }

  Future<void> fetchAllFavorites() async {
    try {
      mainStore.tracksStore.setFavoritesLoadingStatus(true);
      var data = await FirestoreService.instance.readData(favoritesNode);

      Map<String, Track> favoriteTracks = {
        for (var trackData in data)
          Track.fromJson(trackData).id: Track.fromJson(trackData)
      };
      mainStore.tracksStore.setFavoriteTracks(favoriteTracks);
      listenToFavoriteChanges();
    } catch (e) {
      print(e.toString());
    } finally {
      mainStore.tracksStore.setFavoritesLoadingStatus(false);
    }
  }

  Future<void> setAsFavorite(Track track) async {
    try {
      String documentPath = '$favoritesNode/${track.id}';
      await FirestoreService.instance.writeData(
        documentPath,
        track.toJson(),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> removeAsFavorite(Track track) async {
    try {
      await FirestoreService.instance.deleteData(
        favoritesNode,
        track.id,
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
