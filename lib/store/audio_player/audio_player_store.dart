import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:music_player/models/tracks.dart';

part 'audio_player_store.g.dart';

class AudioPlayerStore = _AudioPlayerStore with _$AudioPlayerStore;

abstract class _AudioPlayerStore with Store {
  @observable
  Track? currentPlayingTrack;

  AudioPlayer? _audioPlayer;

  StreamSubscription<Duration>? _durationSubscription;
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<PlayerState>? _playerStateSubscription;
  StreamSubscription<void>? _completionSubscription;
  StreamSubscription<String>? _errorSubscription;

  @observable
  Duration position = Duration.zero;

  @observable
  Duration duration = Duration.zero;

  @observable
  PlayerState playerState = PlayerState.stopped;

  @computed
  bool get isPlaying => playerState == PlayerState.playing;

  @action
  Future play(Track track) async {
    currentPlayingTrack = track;

    if (_audioPlayer == null) {
      await _initAudioPlayer();
    }

    await _audioPlayer!.play(UrlSource(track.audio));
  }

  @action
  Future pause() async {
    await _audioPlayer?.pause();
  }

  @action
  Future stop() async {
    await _audioPlayer?.stop();
    position = Duration.zero;
  }

  @action
  Future seek(Duration newPosition) async {
    await _audioPlayer?.seek(newPosition);
  }

  @action
  Future dispose() async {
    await _durationSubscription?.cancel();
    await _positionSubscription?.cancel();
    await _playerStateSubscription?.cancel();
    await _completionSubscription?.cancel();
    await _errorSubscription?.cancel();

    _durationSubscription = null;
    _positionSubscription = null;
    _playerStateSubscription = null;
    _completionSubscription = null;
    _errorSubscription = null;

    await _audioPlayer?.dispose();
    _audioPlayer = null;
  }

  Future<void> _initAudioPlayer() async {
    _audioPlayer = AudioPlayer();

    _durationSubscription =
        _audioPlayer!.onDurationChanged.listen((newDuration) {
      duration = newDuration;
    });

    _positionSubscription =
        _audioPlayer!.onPositionChanged.listen((newPosition) {
      position = newPosition;
    });

    _playerStateSubscription =
        _audioPlayer!.onPlayerStateChanged.listen((state) {
      playerState = state;
    });

    _completionSubscription = _audioPlayer!.onPlayerComplete.listen((event) {
      position = duration;
      playerState = PlayerState.stopped;
    });
  }
}
