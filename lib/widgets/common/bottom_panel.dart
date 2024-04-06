import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:music_player/models/tracks.dart';
import 'package:music_player/store/main_store.dart';
import 'package:music_player/widgets/tracks/track_icon_widgets.dart';
import 'package:music_player/widgets/tracks/track_slider.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class BottomPanel extends StatefulWidget {
  final PanelController controller;
  const BottomPanel({super.key, required this.controller});

  @override
  State<BottomPanel> createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  late MainStore mainStore;

  @override
  void initState() {
    super.initState();
    mainStore = Provider.of<MainStore>(context, listen: false);
  }

  void onTrackCancel() {
    mainStore.audioPlayerStore.dispose();
  }

  Widget _buildTrackCover(Track? track) {
    if (track?.albumImage == null) {
      return Container();
    }

    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          track!.albumImage!,
          width: 50,
          height: 50,
        ),
      ),
    );
  }

  Widget _buildCloseButton() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 4),
      child: GestureDetector(
        onTap: onTrackCancel,
        child: const ActionIcon(
          color: Colors.white,
          radius: 50,
          iconSize: 34,
          icon: Icons.close,
        ),
      ),
    );
  }

  Widget _buildSongInfo(Track? track) {
    if (track == null) {
      return Expanded(child: Container());
    }

    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.only(left: 8.0, right: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              track.name,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              track.artistName,
              style: TextStyle(
                fontSize: 15,
                letterSpacing: 1,
                color: Colors.white.withOpacity(0.8),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayPauseButton(Track? track, bool isPlaying) {
    return GestureDetector(
      onTap: () {
        if (track == null) return;

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

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      Track? track = mainStore.audioPlayerStore.currentPlayingTrack;
      bool isPlaying = mainStore.audioPlayerStore.isPlaying;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildTrackCover(track),
                _buildSongInfo(track),
                _buildPlayPauseButton(track, isPlaying),
                _buildCloseButton(),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10, top: 8),
              child: TrackSlider(),
            ),
          ],
        ),
      );
    });
  }
}
