// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracks_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TrackStore on _TracksStore, Store {
  Computed<List<Track>>? _$filteredFavoritesComputed;

  @override
  List<Track> get filteredFavorites => (_$filteredFavoritesComputed ??=
          Computed<List<Track>>(() => super.filteredFavorites,
              name: '_TracksStore.filteredFavorites'))
      .value;
  Computed<List<Track>>? _$filteredTracksComputed;

  @override
  List<Track> get filteredTracks => (_$filteredTracksComputed ??=
          Computed<List<Track>>(() => super.filteredTracks,
              name: '_TracksStore.filteredTracks'))
      .value;

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

  late final _$favoriteTracksAtom =
      Atom(name: '_TracksStore.favoriteTracks', context: context);

  @override
  ObservableMap<String, Track> get favoriteTracks {
    _$favoriteTracksAtom.reportRead();
    return super.favoriteTracks;
  }

  @override
  set favoriteTracks(ObservableMap<String, Track> value) {
    _$favoriteTracksAtom.reportWrite(value, super.favoriteTracks, () {
      super.favoriteTracks = value;
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

  late final _$areFavoritesLoadingAtom =
      Atom(name: '_TracksStore.areFavoritesLoading', context: context);

  @override
  bool get areFavoritesLoading {
    _$areFavoritesLoadingAtom.reportRead();
    return super.areFavoritesLoading;
  }

  @override
  set areFavoritesLoading(bool value) {
    _$areFavoritesLoadingAtom.reportWrite(value, super.areFavoritesLoading, () {
      super.areFavoritesLoading = value;
    });
  }

  late final _$searchTermAtom =
      Atom(name: '_TracksStore.searchTerm', context: context);

  @override
  String get searchTerm {
    _$searchTermAtom.reportRead();
    return super.searchTerm;
  }

  @override
  set searchTerm(String value) {
    _$searchTermAtom.reportWrite(value, super.searchTerm, () {
      super.searchTerm = value;
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
  void setFavoriteTracks(Map<String, Track> tracks) {
    final _$actionInfo = _$_TracksStoreActionController.startAction(
        name: '_TracksStore.setFavoriteTracks');
    try {
      return super.setFavoriteTracks(tracks);
    } finally {
      _$_TracksStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addTrackToFavorites(Track track) {
    final _$actionInfo = _$_TracksStoreActionController.startAction(
        name: '_TracksStore.addTrackToFavorites');
    try {
      return super.addTrackToFavorites(track);
    } finally {
      _$_TracksStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeTrackFromFavorites(String trackId) {
    final _$actionInfo = _$_TracksStoreActionController.startAction(
        name: '_TracksStore.removeTrackFromFavorites');
    try {
      return super.removeTrackFromFavorites(trackId);
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
  void setSearchTerm(String value) {
    final _$actionInfo = _$_TracksStoreActionController.startAction(
        name: '_TracksStore.setSearchTerm');
    try {
      return super.setSearchTerm(value);
    } finally {
      _$_TracksStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFavoritesLoadingStatus(bool value) {
    final _$actionInfo = _$_TracksStoreActionController.startAction(
        name: '_TracksStore.setFavoritesLoadingStatus');
    try {
      return super.setFavoritesLoadingStatus(value);
    } finally {
      _$_TracksStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tracks: ${tracks},
favoriteTracks: ${favoriteTracks},
isLoading: ${isLoading},
areFavoritesLoading: ${areFavoritesLoading},
searchTerm: ${searchTerm},
filteredFavorites: ${filteredFavorites},
filteredTracks: ${filteredTracks}
    ''';
  }
}
