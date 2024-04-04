import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:music_player/models/tracks.dart';
import 'package:music_player/store/main_store.dart';
import 'package:music_player/widgets/tracks/track_slider.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class MusicControl extends StatelessWidget {
  final PanelController panelController;
  final MainStore mainStore;

  const MusicControl({
    super.key,
    required this.panelController,
    required this.mainStore,
  });

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
        onTap: () => {},
        splashColor: Colors.white60,
        customBorder: const CircleBorder(),
        child: Container(
          padding: const EdgeInsets.all(5),
          child: const Icon(
            Icons.skip_next,
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
        onTap: () => {},
        splashColor: Colors.white60,
        customBorder: const CircleBorder(),
        child: Container(
          padding: const EdgeInsets.all(5),
          child: const Icon(
            Icons.skip_previous,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    );
  }

  Widget playPauseButtonBuilder() {
    return Observer(builder: (_) {
      Track? track = mainStore.audioPlayerStore.currentPlayingTrack;
      bool isPlaying = mainStore.audioPlayerStore.isPlaying;

      return GestureDetector(
        onTap: () {
          if (track != null) {
            if (isPlaying) {
              mainStore.audioPlayerStore.pause();
            } else {
              mainStore.audioPlayerStore.resume();
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
            child: AnimatedCrossFade(
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
            ),
          ),
        ),
      );
    });
  }

  Widget songDurationTime() {
    return Observer(builder: (_) {
      bool isPlaying = mainStore.audioPlayerStore.isPlaying;
      Duration duration = mainStore.audioPlayerStore.duration;

      return Text(
        isPlaying ? getDuration(duration) : "0:00",
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
      Duration position = mainStore.audioPlayerStore.position;

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

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double heightOffset = 75;
    var path = Path();
    path.moveTo(0, heightOffset);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, heightOffset);
    path.conicTo(size.width / 2, -heightOffset, 0, heightOffset, 0.9);

    // path.quadraticBezierTo(size.width / 2, -(heightOffset), 0, heightOffset);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
