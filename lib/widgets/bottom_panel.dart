import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:music_player/models/tracks.dart';
import 'package:music_player/store/main_store.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class BottomPanel extends StatelessWidget {
  final PanelController _controller;

  BottomPanel({required PanelController controller}) : _controller = controller;

  @override
  Widget build(BuildContext context) {
    MainStore mainStore = Provider.of<MainStore>(context, listen: false);

    return Observer(builder: (context) {
      Track? track = mainStore.audioPlayerStore.currentPlayingTrack;
      PlayerState playerState = mainStore.audioPlayerStore.playerState;
      return _buildBottomPanel(track, playerState, mainStore);
    });
  }

  Widget _buildBottomPanel(
      Track? track, PlayerState playerState, MainStore mainStore) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 2,
                child: _buildPlayPauseButton(track, playerState),
              ),
              Flexible(
                flex: 8,
                child: _buildSongInfo(track),
              ),
              Flexible(
                flex: 1,
                child: GestureDetector(
                  onTap: () => _controller.open(),
                  child: const ShowIcon(color: Colors.white),
                ),
              ),
            ],
          ),
          Observer(builder: (context) {
            Duration position = mainStore.audioPlayerStore.position;
            Duration duration = mainStore.audioPlayerStore.duration;

            if (playerState == PlayerState.stopped) {
              return Slider(
                value: 0,
                onChanged: (value) {},
                activeColor: Colors.transparent,
                inactiveColor: Colors.transparent,
              );
            }

            return Slider(
              min: 0,
              max: duration.inMilliseconds.toDouble(),
              value: position.inMilliseconds.toDouble(),
              onChangeStart: (value) {
                // _globalBloc.musicPlayerBloc.invertSeekingState();
              },
              onChanged: (value) {
                // _globalBloc.musicPlayerBloc
                //     .updatePosition(Duration(milliseconds: value.toInt()));
              },
              onChangeEnd: (value) {
                // _globalBloc.musicPlayerBloc.invertSeekingState();
                // _globalBloc.musicPlayerBloc.audioSeek(value / 1000);
                mainStore.audioPlayerStore.seek(
                  Duration(milliseconds: value.toInt()),
                );
              },
              activeColor: Colors.white,
              inactiveColor: Colors.white.withOpacity(0.5),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPlayPauseButton(Track? track, PlayerState playerState) {
    return GestureDetector(
      onTap: () {
        if (track == null) {
          return;
        }

        if (PlayerState.paused == playerState) {
          // Play Music
        } else {
          // Pause Music
        }
      },
      child: Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        child: playerState == PlayerState.playing
            ? const PauseIcon(color: Colors.white)
            : PlayIcon(color: Colors.white),
      ),
    );
  }

  Widget _buildSongInfo(Track? track) {
    if (track == null) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            track.name,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Divider(height: 10, color: Colors.transparent),
          Text(
            track.artistName,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              letterSpacing: 1,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class PlayIcon extends StatelessWidget {
  final Color _color;

  PlayIcon({required Color color}) : _color = color;

  @override
  Widget build(BuildContext context) {
    final double _radius = 55;
    return Container(
      width: _radius,
      height: _radius,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: _color,
        ),
        borderRadius: BorderRadius.circular(
          _radius,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.play_arrow,
          color: _color,
          size: 32.0,
        ),
      ),
    );
  }
}

class PauseIcon extends StatelessWidget {
  final Color _color;

  const PauseIcon({super.key, required Color color}) : _color = color;

  @override
  Widget build(BuildContext context) {
    const double radius = 55;
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: _color,
        ),
        borderRadius: BorderRadius.circular(
          radius,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.pause,
          color: _color,
          size: 32.0,
        ),
      ),
    );
  }
}

class ShowIcon extends StatelessWidget {
  final Color _color;

  const ShowIcon({super.key, required Color color}) : _color = color;

  @override
  Widget build(BuildContext context) {
    const double radius = 32;
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: _color,
        ),
        borderRadius: BorderRadius.circular(
          radius,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.keyboard_arrow_up,
          color: _color,
          size: 22.0,
        ),
      ),
    );
  }
}

class HideIcon extends StatelessWidget {
  final Color _color;

  const HideIcon({super.key, required Color color}) : _color = color;

  @override
  Widget build(BuildContext context) {
    const double radius = 32;
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: _color,
        ),
        borderRadius: BorderRadius.circular(
          radius,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.keyboard_arrow_down,
          color: _color,
          size: 22.0,
        ),
      ),
    );
  }
}
