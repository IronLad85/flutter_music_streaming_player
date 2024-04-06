import 'package:flutter/material.dart';
import 'package:music_player/models/tracks.dart';
import 'package:music_player/screens/track/track_details_page.dart';
import 'package:music_player/store/main_store.dart';
import 'package:music_player/utils/theme_data.dart';
import 'package:music_player/widgets/tracks/favorite_button.dart';
import 'package:provider/provider.dart';

class TrackListTile extends StatelessWidget {
  final Track track;
  const TrackListTile({super.key, required this.track});

  Widget _buildFavoriteIcon(BuildContext context) {
    return Builder(builder: (context) {
      MainStore mainStore = Provider.of<MainStore>(context, listen: false);
      bool isFavorite = mainStore.tracksStore.isFavoriteTrack(track.id);
      return TrackFavoriteButton(track: track, isFavorite: isFavorite);
    });
  }

  _playAudioTrack(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          return TrackDetailsPage(track: track);
        },
      ),
    );
  }

  Widget _buildTrackImage() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 30),
      child: Hero(
        tag: track.id,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: Colors.grey.shade300,
            child: Builder(builder: (context) {
              if (track.albumImage == null) {
                return Container();
              }

              return Image.network(
                track.albumImage!,
                width: 70,
                height: 70,
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildTrackInfo(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            track.name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: context.theme.brightTextColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            track.artistName,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: context.theme.lightTextColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _playAudioTrack(context),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          children: [
            _buildTrackImage(),
            _buildTrackInfo(context),
            _buildFavoriteIcon(context),
          ],
        ),
      ),
    );
  }
}
