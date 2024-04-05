// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_player_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AudioPlayerStore on _AudioPlayerStore, Store {
  Computed<bool>? _$isPlayingComputed;

  @override
  bool get isPlaying =>
      (_$isPlayingComputed ??= Computed<bool>(() => super.isPlaying,
              name: '_AudioPlayerStore.isPlaying'))
          .value;

  late final _$currentPlayingTrackAtom =
      Atom(name: '_AudioPlayerStore.currentPlayingTrack', context: context);

  @override
  Track? get currentPlayingTrack {
    _$currentPlayingTrackAtom.reportRead();
    return super.currentPlayingTrack;
  }

  @override
  set currentPlayingTrack(Track? value) {
    _$currentPlayingTrackAtom.reportWrite(value, super.currentPlayingTrack, () {
      super.currentPlayingTrack = value;
    });
  }

  late final _$isTrackLoadingAtom =
      Atom(name: '_AudioPlayerStore.isTrackLoading', context: context);

  @override
  bool get isTrackLoading {
    _$isTrackLoadingAtom.reportRead();
    return super.isTrackLoading;
  }

  @override
  set isTrackLoading(bool value) {
    _$isTrackLoadingAtom.reportWrite(value, super.isTrackLoading, () {
      super.isTrackLoading = value;
    });
  }

  late final _$seekValueAtom =
      Atom(name: '_AudioPlayerStore.seekValue', context: context);

  @override
  Duration get seekValue {
    _$seekValueAtom.reportRead();
    return super.seekValue;
  }

  @override
  set seekValue(Duration value) {
    _$seekValueAtom.reportWrite(value, super.seekValue, () {
      super.seekValue = value;
    });
  }

  late final _$isSeekingAtom =
      Atom(name: '_AudioPlayerStore.isSeeking', context: context);

  @override
  bool get isSeeking {
    _$isSeekingAtom.reportRead();
    return super.isSeeking;
  }

  @override
  set isSeeking(bool value) {
    _$isSeekingAtom.reportWrite(value, super.isSeeking, () {
      super.isSeeking = value;
    });
  }

  late final _$positionAtom =
      Atom(name: '_AudioPlayerStore.position', context: context);

  @override
  Duration get position {
    _$positionAtom.reportRead();
    return super.position;
  }

  @override
  set position(Duration value) {
    _$positionAtom.reportWrite(value, super.position, () {
      super.position = value;
    });
  }

  late final _$durationAtom =
      Atom(name: '_AudioPlayerStore.duration', context: context);

  @override
  Duration get duration {
    _$durationAtom.reportRead();
    return super.duration;
  }

  @override
  set duration(Duration value) {
    _$durationAtom.reportWrite(value, super.duration, () {
      super.duration = value;
    });
  }

  late final _$playerStateAtom =
      Atom(name: '_AudioPlayerStore.playerState', context: context);

  @override
  PlayerState get playerState {
    _$playerStateAtom.reportRead();
    return super.playerState;
  }

  @override
  set playerState(PlayerState value) {
    _$playerStateAtom.reportWrite(value, super.playerState, () {
      super.playerState = value;
    });
  }

  late final _$playAsyncAction =
      AsyncAction('_AudioPlayerStore.play', context: context);

  @override
  Future<dynamic> play(Track track) {
    return _$playAsyncAction.run(() => super.play(track));
  }

  late final _$resumeAsyncAction =
      AsyncAction('_AudioPlayerStore.resume', context: context);

  @override
  Future<dynamic> resume() {
    return _$resumeAsyncAction.run(() => super.resume());
  }

  late final _$pauseAsyncAction =
      AsyncAction('_AudioPlayerStore.pause', context: context);

  @override
  Future<dynamic> pause() {
    return _$pauseAsyncAction.run(() => super.pause());
  }

  late final _$stopAsyncAction =
      AsyncAction('_AudioPlayerStore.stop', context: context);

  @override
  Future<dynamic> stop() {
    return _$stopAsyncAction.run(() => super.stop());
  }

  late final _$seekAsyncAction =
      AsyncAction('_AudioPlayerStore.seek', context: context);

  @override
  Future<dynamic> seek(Duration newPosition) {
    return _$seekAsyncAction.run(() => super.seek(newPosition));
  }

  late final _$setSeekValueAsyncAction =
      AsyncAction('_AudioPlayerStore.setSeekValue', context: context);

  @override
  Future<dynamic> setSeekValue(Duration duration,
      {bool isSeekingValue = false}) {
    return _$setSeekValueAsyncAction.run(
        () => super.setSeekValue(duration, isSeekingValue: isSeekingValue));
  }

  late final _$clearCurrentTrackAsyncAction =
      AsyncAction('_AudioPlayerStore.clearCurrentTrack', context: context);

  @override
  Future<void> clearCurrentTrack() {
    return _$clearCurrentTrackAsyncAction.run(() => super.clearCurrentTrack());
  }

  late final _$disposeAsyncAction =
      AsyncAction('_AudioPlayerStore.dispose', context: context);

  @override
  Future<dynamic> dispose() {
    return _$disposeAsyncAction.run(() => super.dispose());
  }

  late final _$_AudioPlayerStoreActionController =
      ActionController(name: '_AudioPlayerStore', context: context);

  @override
  void setTrackLoadingStatus(bool value) {
    final _$actionInfo = _$_AudioPlayerStoreActionController.startAction(
        name: '_AudioPlayerStore.setTrackLoadingStatus');
    try {
      return super.setTrackLoadingStatus(value);
    } finally {
      _$_AudioPlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPlayingTrack: ${currentPlayingTrack},
isTrackLoading: ${isTrackLoading},
seekValue: ${seekValue},
isSeeking: ${isSeeking},
position: ${position},
duration: ${duration},
playerState: ${playerState},
isPlaying: ${isPlaying}
    ''';
  }
}
