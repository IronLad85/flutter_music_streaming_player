// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracks_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TrackStore on _TracksStore, Store {
  late final _$tracksAtom = Atom(name: '_TracksStore.tracks', context: context);

  @override
  ObservableList<Track> get tracks {
    _$tracksAtom.reportRead();
    return super.tracks;
  }

  @override
  set tracks(ObservableList<Track> value) {
    _$tracksAtom.reportWrite(value, super.tracks, () {
      super.tracks = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_TracksStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$_TracksStoreActionController =
      ActionController(name: '_TracksStore', context: context);

  @override
  void setTracks(List<Track> newTracks) {
    final _$actionInfo = _$_TracksStoreActionController.startAction(
        name: '_TracksStore.setTracks');
    try {
      return super.setTracks(newTracks);
    } finally {
      _$_TracksStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_TracksStoreActionController.startAction(
        name: '_TracksStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_TracksStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tracks: ${tracks},
isLoading: ${isLoading}
    ''';
  }
}
