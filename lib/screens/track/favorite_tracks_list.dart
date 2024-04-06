import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:music_player/models/tracks.dart';
import 'package:music_player/store/main_store.dart';
import 'package:music_player/utils/theme_data.dart';
import 'package:music_player/widgets/tracks/track_list_tile.dart';
import 'package:provider/provider.dart';

class FavoriteTracksList extends StatelessWidget {
  const FavoriteTracksList({super.key});

  Widget _buildEmptyPlaceholder(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.info_outlined,
            size: 45,
            color: context.theme.lightTextColor,
          ),
          const SizedBox(height: 10),
          Text(
            'There are no Favorites',
            style: TextStyle(
              fontSize: 22,
              color: context.theme.lightTextColor,
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MainStore mainStore = Provider.of<MainStore>(context, listen: false);

    return Observer(
      builder: (context) {
        List<Track> tracks = mainStore.tracksStore.filteredFavorites;

        if (tracks.isEmpty) {
          return _buildEmptyPlaceholder(context);
        }

        return ListView.builder(
          itemCount: tracks.length,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 140),
          itemBuilder: (context, index) {
            return TrackListTile(
              track: tracks[index],
            );
          },
        );
      },
    );
  }
}
