import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:music_player/models/tracks.dart';
import 'package:music_player/store/main_store.dart';
import 'package:music_player/widgets/tracks/track_icon_widgets.dart';
import 'package:music_player/widgets/tracks/track_slider.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class BottomPanel extends StatelessWidget {
  final PanelController controller;
  const BottomPanel({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    MainStore mainStore = Provider.of<MainStore>(context, listen: false);

    return Observer(builder: (context) {
      Track? track = mainStore.audioPlayerStore.currentPlayingTrack;
      bool isPlaying = mainStore.audioPlayerStore.isPlaying;
      return _buildBottomPanel(track, isPlaying, mainStore);
    });
  }

  Widget _buildBottomPanel(Track? track, bool isPlaying, MainStore mainStore) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildPlayPauseButton(track, isPlaying, mainStore),
              Expanded(child: _buildSongInfo(track)),
              GestureDetector(
                onTap: () => controller.open(),
                child: const ShowIcon(color: Colors.white),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 5, top: 5),
            child: TrackSlider(),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayPauseButton(
    Track? track,
    bool isPlaying,
    MainStore mainStore,
  ) {
    return GestureDetector(
      onTap: () {
        if (track == null) {
          return;
        }

        if (isPlaying) {
          mainStore.audioPlayerStore.pause();
        } else {
          mainStore.audioPlayerStore.resume();
        }
      },
      child: Container(
        alignment: Alignment.centerLeft,
        child: isPlaying
            ? const PauseIcon(color: Colors.white)
            : const PlayIcon(color: Colors.white),
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
        mainAxisSize: MainAxisSize.min,
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
