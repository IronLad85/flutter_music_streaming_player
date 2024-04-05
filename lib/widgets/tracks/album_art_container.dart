import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:music_player/store/audio_player/audio_player_store.dart';

import 'package:music_player/store/main_store.dart';
import 'package:provider/provider.dart';

class AlbumArtContainer extends StatefulWidget {
  const AlbumArtContainer({
    super.key,
    required this.heroTag,
    required this.radius,
    required this.albumArtSize,
    required this.albumImage,
  });

  @override
  State<AlbumArtContainer> createState() => _AlbumArtContailerState();

  final double radius;
  final double albumArtSize;
  final String albumImage;
  final String heroTag;
}

class _AlbumArtContailerState extends State<AlbumArtContainer>
    with SingleTickerProviderStateMixin {
  late MainStore mainStore;
  late AnimationController _animationController;

  StreamSubscription<Duration>? durationStreamSubscription;
  ReactionDisposer? pausedSeekerDisposer;

  bool isAudioSeeking = false;
  double tickerValue = 0;
  bool isAlbumHeroTransitionComplete = false;

  AudioPlayerStore get audioPlayerStore => mainStore.audioPlayerStore;

  List<BoxShadow>? get albumArtShadow {
    bool isTrackLoading = audioPlayerStore.isTrackLoading;

    if (isTrackLoading) {
      return [];
    }

    return [
      const BoxShadow(
        offset: Offset(0, 2),
        spreadRadius: 0.1,
        blurRadius: 20,
        color: Color.fromRGBO(255, 182, 193, 0.75),
      )
    ];
  }

  @override
  void initState() {
    super.initState();
    mainStore = Provider.of<MainStore>(context, listen: false);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(hours: 1),
    )..repeat();

    _animationController.addListener(() {
      if (audioPlayerStore.isPlaying) {
        Duration position = audioPlayerStore.position;
        double progressInSeconds =
            position.inSeconds + (position.inMilliseconds % 1000) / 1000.0;

        double value = _convertSeekValueIntoRadians(progressInSeconds);
        setState(() => tickerValue = value);
      }
    });

    pausedSeekerDisposer = reaction((_) => audioPlayerStore.seekValue, (_) {
      if (!audioPlayerStore.isPlaying) setState(() {});
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() => isAlbumHeroTransitionComplete = true);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    durationStreamSubscription?.cancel();
    super.dispose();
  }

  double _convertSeekValueIntoRadians(double seconds) {
    return (seconds * 25) * (pi / 180);
  }

  CrossFadeState get getAlbumArtFadeState {
    bool canRotateAlbumArt =
        !audioPlayerStore.isTrackLoading && isAlbumHeroTransitionComplete;

    return canRotateAlbumArt
        ? CrossFadeState.showSecond
        : CrossFadeState.showFirst;
  }

  Widget _renderGradient() {
    return Opacity(
      opacity: 0.4,
      child: Container(
        width: double.infinity,
        height: widget.albumArtSize,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [0.0, 0.85],
            colors: [
              Color(0xFF47ACE1),
              Color(0xFFDF5F9D),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStaticAlbumArt() {
    return Hero(
      tag: widget.heroTag,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Image.network(widget.albumImage),
            ),
            _renderGradient()
          ],
        ),
      ),
    );
  }

  Widget _buildRotatingAlbumArt() {
    Duration seekValue = audioPlayerStore.seekValue;
    double radians = _convertSeekValueIntoRadians(
      seekValue.inSeconds.toDouble(),
    );
    bool isSeeking = audioPlayerStore.isSeeking;

    return Transform.rotate(
      angle: isSeeking ? radians : tickerValue,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius),
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.network(widget.albumImage),
              ),
              _renderGradient()
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50, bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius),
          boxShadow: albumArtShadow,
        ),
        child: Builder(builder: (context) {
          return Builder(builder: (context) {
            return AnimatedCrossFade(
              firstCurve: Curves.easeInOut,
              secondCurve: Curves.easeInOut,
              firstChild: _buildStaticAlbumArt(),
              secondChild: _buildRotatingAlbumArt(),
              crossFadeState: getAlbumArtFadeState,
              duration: const Duration(milliseconds: 400),
            );
          });
        }),
      ),
    );
  }
}
