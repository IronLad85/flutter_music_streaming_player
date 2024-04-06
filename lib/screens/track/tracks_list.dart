import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:music_player/models/tracks.dart';
import 'package:music_player/services/favorite_service.dart';
import 'package:music_player/services/music_service.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:music_player/store/main_store.dart';
import 'package:music_player/utils/theme_data.dart';
import 'package:music_player/widgets/track_list_tile.dart';
import 'package:provider/provider.dart';

class TracksList extends StatefulWidget {
  const TracksList({super.key});

  @override
  State<TracksList> createState() => _TracksListState();
}

class _TracksListState extends State<TracksList> {
  late MainStore mainStore;

  @override
  void initState() {
    super.initState();
    mainStore = Provider.of<MainStore>(context, listen: false);

    _fetchTracks();
    mainStore.tracksStore.pagingController.addPageRequestListener((pageKey) {
      _fetchTracks();
    });
  }

  Future<void> _fetchTracks() async {
    int itemsCount = mainStore.tracksStore.tracks.length;
    await MusicService.instance.fetchTracks(offset: itemsCount);
    await FavoritesService.instance.fetchAllFavorites();
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: SizedBox(
        width: 60,
        height: 60,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    List<Track> tracks = mainStore.tracksStore.filteredTracks;

    return ListView.builder(
      itemCount: tracks.length,
      itemBuilder: (context, index) {
        return TrackListTile(track: tracks[index]);
      },
    );
  }

  Widget _buildPaginatedListView(
    PagingController<int, Track> pagingController,
  ) {
    return PagedListView<int, Track>(
      pagingController: mainStore.tracksStore.pagingController,
      builderDelegate: PagedChildBuilderDelegate<Track>(
        itemBuilder: (context, trackItem, index) {
          return TrackListTile(track: trackItem);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: context.theme.pageBackgroundColor,
        child: Observer(
          builder: (context) {
            String searchTerm = mainStore.tracksStore.searchTerm;

            bool areTracksLoading = mainStore.tracksStore.isLoading;
            bool areFavLoading = mainStore.tracksStore.areFavoritesLoading;
            bool isLoading = areTracksLoading || areFavLoading;

            if (isLoading && mainStore.tracksStore.tracks.isEmpty) {
              return _buildLoadingIndicator();
            }

            if (searchTerm.isNotEmpty) {
              return _buildSearchResults();
            }

            return _buildPaginatedListView(
              mainStore.tracksStore.pagingController,
            );
          },
        ),
      ),
    );
  }
}
