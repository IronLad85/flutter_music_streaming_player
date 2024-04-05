import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:music_player/models/tracks.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

part 'audio_player_store.g.dart';

class AudioPlayerStore = _AudioPlayerStore with _$AudioPlayerStore;

abstract class _AudioPlayerStore with Store {
  @observable
  Track? currentPlayingTrack;

  AudioPlayer? _audioPlayer;

  @observable
  bool isTrackLoading = false;

  StreamSubscription<Duration>? _durationSubscription;
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<PlayerState>? _playerStateSubscription;
  StreamSubscription<void>? _completionSubscription;
  StreamSubscription<String>? _errorSubscription;
  final PanelController panelController = PanelController();

  @observable
  Duration seekValue = Duration.zero;

  @observable
  bool isSeeking = false;

  @observable
  Duration position = Duration.zero;

  @observable
  Duration duration = Duration.zero;

  @observable
  PlayerState playerState = PlayerState.stopped;

  @computed
  bool get isPlaying => playerState == PlayerState.playing;

  AudioPlayer? get audioPlayer => _audioPlayer;

  bool isPlayingCurrentTrack(Track? track) {
    if (track == null || currentPlayingTrack == null) return false;

    return track.id == currentPlayingTrack?.id;
  }

  @action
  void setTrackLoadingStatus(bool value) {
    isTrackLoading = value;
  }

  @action
  Future play(Track track) async {
    currentPlayingTrack = track;
    setTrackLoadingStatus(true);

    if (_audioPlayer == null) {
      await _initAudioPlayer();
    }

    await _audioPlayer!.play(UrlSource(track.audio));
    setTrackLoadingStatus(false);
  }

  @action
  Future resume() async {
    bool isTrackCompleted = position.inSeconds >= duration.inSeconds;
    if (currentPlayingTrack != null && isTrackCompleted) {
      await play(currentPlayingTrack!);
    } else {
      await _audioPlayer?.resume();
    }
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

  void fastRewindTrack() {
    const int rewindMilliseconds = 10 * 1000;
    final newPosition = position.inMilliseconds > rewindMilliseconds
        ? position - const Duration(milliseconds: rewindMilliseconds)
        : Duration.zero;

    seek(newPosition);
  }

  void fastForwardTrack() {
    const int skipMilliseconds = 10 * 1000;
    if (duration.inMilliseconds - position.inMilliseconds > skipMilliseconds) {
      var duration = position + const Duration(milliseconds: skipMilliseconds);
      seek(duration);
    } else {
      seek(duration);
    }
  }

  @action
  Future seek(Duration newPosition) async {
    if (audioPlayer != null) {
      switch (playerState) {
        case PlayerState.completed:
          setTrackLoadingStatus(true);
          await _audioPlayer?.play(
            UrlSource(currentPlayingTrack!.audio),
            position: newPosition,
          );
          setTrackLoadingStatus(false);

        case PlayerState.playing:
          await _audioPlayer?.seek(newPosition);

        case PlayerState.paused:
          await _audioPlayer?.seek(newPosition);

        default:
      }
    }
  }

  @action
  Future setSeekValue(
    Duration duration, {
    bool isSeekingValue = false,
  }) async {
    seekValue = duration;
    isSeeking = isSeekingValue;
  }

  @action
  Future<void> clearCurrentTrack() async {
    duration = Duration.zero;
    position = Duration.zero;
    seekValue = Duration.zero;
    await _audioPlayer?.pause();
  }

  @action
  Future dispose() async {
    await _durationSubscription?.cancel();
    await _positionSubscription?.cancel();
    await _playerStateSubscription?.cancel();
    await _completionSubscription?.cancel();
    await _errorSubscription?.cancel();

    duration = Duration.zero;
    position = Duration.zero;

    _durationSubscription = null;
    _positionSubscription = null;
    _playerStateSubscription = null;
    _completionSubscription = null;
    _errorSubscription = null;
    currentPlayingTrack = null;

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
      if (!isSeeking) {
        setSeekValue(newPosition);
      }
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
