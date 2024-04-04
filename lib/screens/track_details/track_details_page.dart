import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:music_player/models/tracks.dart';
import 'package:music_player/store/main_store.dart';
import 'package:music_player/widgets/tracks/album_art_container.dart';
import 'package:music_player/widgets/tracks/empty_album_container.dart';
import 'package:music_player/widgets/tracks/music_control.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class NowPlayingScreen extends StatefulWidget {
  final PanelController controller;
  const NowPlayingScreen({super.key, required this.controller});

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  late MainStore mainStore;
  double _albumArtSize = 0;

  @override
  void initState() {
    super.initState();
    mainStore = Provider.of<MainStore>(context, listen: false);
  }

  Widget _buildTrackName(String trackName) {
    return Text(
      trackName,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 22,
        color: Color(0xFF4D6B9C),
        fontWeight: FontWeight.w600,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildAlbumName(String albumName) {
    return Text(
      "Album: $albumName",
      style: const TextStyle(
        fontSize: 18,
        color: Colors.black38,
        letterSpacing: 0.5,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _renderSongInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Observer(builder: (_) {
        Track? track = mainStore.audioPlayerStore.currentPlayingTrack;

        if (track == null) {
          return Container();
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 7),
              child: _buildTrackName(track.name),
            ),
            _buildAlbumName(track.albumName),
          ],
        );
      }),
    );
  }

  Widget topbar() {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 20),
      child: (Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            customBorder: const CircleBorder(),
            splashColor: Colors.black38,
            onTap: widget.controller.close,
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Icon(Icons.arrow_back_ios, color: Colors.black54),
            ),
          ),
          const Expanded(
              child: Text(
            "Now Playing",
            style: TextStyle(
                fontSize: 24,
                color: Colors.black45,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5),
            textAlign: TextAlign.center,
          )),
          const Icon(Icons.arrow_back_ios, color: Colors.transparent)
        ],
      )),
    );
  }

  Widget songInfoBuilder() {
    double radius = 500;
    return Observer(builder: (_) {
      Track? track = mainStore.audioPlayerStore.currentPlayingTrack;

      if (track == null) {
        return Container();
      }

      if (track.albumImage == null) {
        return EmptyAlbumArtContainer(
          radius: radius,
          iconSize: _albumArtSize / 2.5,
        );
      } else {
        return Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AlbumArtContainer(
                radius: radius,
                albumArtSize: _albumArtSize,
                albumImage: track.albumImage!,
              ),
              _renderSongInfo()
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _albumArtSize = MediaQuery.of(context).size.height / 2.1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            topbar(),
            Expanded(child: songInfoBuilder()),
            MusicControl(
              mainStore: mainStore,
              panelController: widget.controller,
            ),
            const SizedBox(height: 72)
          ],
        ),
      ),
    );
  }
}
