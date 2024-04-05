import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:music_player/models/tracks.dart';
import 'package:music_player/services/favorite_service.dart';
import 'package:music_player/store/main_store.dart';
import 'package:music_player/utils/theme_data.dart';
import 'package:music_player/widgets/tracks/album_art_container.dart';
import 'package:music_player/widgets/tracks/empty_album_container.dart';
import 'package:music_player/widgets/tracks/music_control.dart';
import 'package:music_player/widgets/tracks/track_icon_widgets.dart';
import 'package:provider/provider.dart';

class TrackDetailsPage extends StatefulWidget {
  final Track track;
  const TrackDetailsPage({super.key, required this.track});

  @override
  State<TrackDetailsPage> createState() => _TrackDetailsPageState();
}

class _TrackDetailsPageState extends State<TrackDetailsPage> {
  late MainStore mainStore;
  double _albumArtSize = 0;

  @override
  void initState() {
    super.initState();
    mainStore = Provider.of<MainStore>(context, listen: false);
    playCurrentTrack();
  }

  void playCurrentTrack() {
    if (mainStore.audioPlayerStore.isPlayingCurrentTrack(widget.track)) {
      return;
    }

    mainStore.audioPlayerStore.clearCurrentTrack();
    mainStore.audioPlayerStore.play(widget.track);
  }

  Future<void> onFavoriteToggle(bool canMarkAsFavorite) async {
    try {
      HapticFeedback.heavyImpact();
      if (canMarkAsFavorite) {
        await FavoritesService.instance.setAsFavorite(widget.track);
      } else {
        await FavoritesService.instance.removeAsFavorite(widget.track);
      }
    } catch (error) {
      print(error);
    } finally {
      setState(() {});
    }
  }

  Widget _buildBackButton() {
    return Container(
      width: 50,
      alignment: Alignment.centerLeft,
      child: InkWell(
        customBorder: const CircleBorder(),
        splashColor: Colors.black38,
        onTap: Navigator.of(context).pop,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(
            Icons.arrow_back_ios,
            color: context.theme.mediumTextColor,
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return Builder(builder: (context) {
      bool isFavorite = mainStore.tracksStore.isFavoriteTrack(widget.track.id);

      return Container(
        width: 50,
        alignment: Alignment.center,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => onFavoriteToggle(!isFavorite),
          child: FavoriteIcon(
            isFavorite: isFavorite,
            size: 32,
          ),
        ),
      );
    });
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
      style: TextStyle(
        fontSize: 18,
        color: context.theme.lightTextColor.withOpacity(0.5),
        letterSpacing: 0.5,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSongInfo() {
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

  Widget _buildTopbar() {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildBackButton(),
          Expanded(
            child: Text(
              "Now Playing",
              style: TextStyle(
                fontSize: 22,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w500,
                color: context.theme.mediumTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          _buildFavoriteButton(),
        ],
      ),
    );
  }

  Widget _buildSongInfoRow() {
    double radius = 500;
    return Observer(
      builder: (_) {
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
                  albumArtSize: _albumArtSize,
                  albumImage: track.albumImage!,
                  heroTag: track.id,
                  radius: radius,
                ),
                _buildSongInfo()
              ],
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _albumArtSize = MediaQuery.of(context).size.height / 2.1;

    return Scaffold(
      backgroundColor: context.theme.pageBackgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildTopbar(),
            Expanded(child: _buildSongInfoRow()),
            MusicControl(mainStore: mainStore),
          ],
        ),
      ),
    );
  }
}
