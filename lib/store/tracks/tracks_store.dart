import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mobx/mobx.dart';
import 'package:music_player/models/tracks.dart';

part 'tracks_store.g.dart';

class TrackStore = _TracksStore with _$TrackStore;

abstract class _TracksStore with Store {
  @observable
  ObservableList<Track> tracks = ObservableList<Track>();

  @observable
  ObservableMap<String, Track> favoriteTracks = ObservableMap.of({});

  final PagingController<int, Track> pagingController =
      PagingController(firstPageKey: 0);

  @observable
  bool isLoading = false;

  @observable
  bool areFavoritesLoading = false;

  @observable
  String searchTerm = '';

  @computed
  List<Track> get filteredFavorites {
    return favoriteTracks.values.where((track) {
      String searchKey = searchTerm.trim().toLowerCase();
      List<String> searchableProperties = [track.name, track.albumName];
      bool containsSearchKey = false;

      for (String string in searchableProperties) {
        if (string.trim().toLowerCase().contains(searchKey)) {
          containsSearchKey = true;
        }
      }

      return containsSearchKey;
    }).toList();
  }

  @computed
  List<Track> get filteredTracks {
    return tracks.where((track) {
      String searchKey = searchTerm.trim().toLowerCase();
      List<String> searchableProperties = [track.name, track.albumName];
      bool containsSearchKey = false;

      for (String string in searchableProperties) {
        if (string.trim().toLowerCase().contains(searchKey)) {
          containsSearchKey = true;
        }
      }

      return containsSearchKey;
    }).toList();
  }

  bool isFavoriteTrack(String trackId) {
    return favoriteTracks[trackId] != null;
  }

  @action
  void setTracks(List<Track> newTracks) {
    tracks = ObservableList.of([...tracks, ...newTracks]);
    pagingController.appendPage(newTracks, newTracks.length);
  }

  @action
  void setFavoriteTracks(Map<String, Track> tracks) {
    favoriteTracks = ObservableMap.of(tracks);
  }

  @action
  void addTrackToFavorites(Track track) {
    if (favoriteTracks[track.id] == null) {
      favoriteTracks[track.id] = track;
    }
  }

  @action
  void removeTrackFromFavorites(String trackId) {
    if (favoriteTracks[trackId] != null) {
      favoriteTracks.remove(trackId);
    }
  }

  @action
  void setLoading(bool value) {
    isLoading = value;
  }

  @action
  void setSearchTerm(String value) {
    searchTerm = value;
  }

  @action
  void setFavoritesLoadingStatus(bool value) {
    areFavoritesLoading = value;
  }
}
