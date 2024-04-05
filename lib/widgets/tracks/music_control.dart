import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:music_player/models/tracks.dart';
import 'package:music_player/store/audio_player/audio_player_store.dart';
import 'package:music_player/store/main_store.dart';
import 'package:music_player/widgets/tracks/track_slider.dart';
import 'package:music_player/widgets/util/curve_clipper.dart';

class MusicControl extends StatelessWidget {
  final MainStore mainStore;
  const MusicControl({super.key, required this.mainStore});

  AudioPlayerStore get audioPlayerStore => mainStore.audioPlayerStore;

  String getRunningDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (twoDigits(duration.inHours) != '00') {
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  String getDuration(Duration duration) {
    final int temp = duration.inSeconds;
    final int minutes = (temp / 60).floor();
    final int seconds = (((temp / 60) - minutes) * 60).round();
    if (seconds.toString().length != 1) {
      return "$minutes:$seconds";
    } else {
      return "$minutes:0$seconds";
    }
  }

  Widget nextButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: audioPlayerStore.fastForwardTrack,
        splashColor: Colors.white60,
        customBorder: const CircleBorder(),
        child: Container(
          padding: const EdgeInsets.all(5),
          child: const Icon(
            Icons.fast_forward,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    );
  }

  Widget previousButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: audioPlayerStore.fastRewindTrack,
        splashColor: Colors.white60,
        customBorder: const CircleBorder(),
        child: Container(
          padding: const EdgeInsets.all(5),
          child: const Icon(
            Icons.fast_rewind,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    );
  }

  Widget playPauseButtonBuilder() {
    return Observer(builder: (_) {
      Track? track = audioPlayerStore.currentPlayingTrack;
      bool isPlaying = audioPlayerStore.isPlaying;

      return GestureDetector(
        onTap: () {
          if (track != null) {
            if (isPlaying) {
              audioPlayerStore.pause();
            } else {
              audioPlayerStore.resume();
            }
          }
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromRGBO(245, 49, 96, 1),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.24),
                blurRadius: 15,
                offset: Offset(3, 3),
              ),
            ],
          ),
          child: Center(
            child: Observer(builder: (context) {
              bool isLoading = audioPlayerStore.isTrackLoading;
              if (isLoading) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: const SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.white,
                    ),
                  ),
                );
              }

              return AnimatedCrossFade(
                duration: const Duration(milliseconds: 200),
                crossFadeState: isPlaying
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: const Icon(
                  Icons.pause,
                  size: 50,
                  color: Colors.white,
                ),
                secondChild: const Icon(
                  Icons.play_arrow,
                  size: 50,
                  color: Colors.white,
                ),
              );
            }),
          ),
        ),
      );
    });
  }

  Widget songDurationTime() {
    return Observer(builder: (_) {
      Duration duration = audioPlayerStore.duration;

      return Text(
        getDuration(duration),
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
          letterSpacing: 1,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    });
  }

  Widget songPlayingTime() {
    return Observer(builder: (_) {
      Duration position = audioPlayerStore.position;

      return Text(
        getRunningDuration(position),
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
          letterSpacing: 1,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurveClipper(),
      child: Container(
        padding: const EdgeInsets.only(top: 50, bottom: 30),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(245, 87, 108, 1),
              Color.fromRGBO(200, 23, 105, 1)
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(child: previousButton()),
                  Flexible(child: playPauseButtonBuilder()),
                  Flexible(child: nextButton()),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  songPlayingTime(),
                  const Expanded(
                    child: TrackSlider(),
                  ),
                  songDurationTime()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
