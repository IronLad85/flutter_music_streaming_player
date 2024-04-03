import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:music_player/models/tracks.dart';
import 'package:music_player/services/music_service.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:music_player/store/main_store.dart';
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

  void _fetchTracks() async {
    int itemsCount = mainStore.tracksStore.tracks.length;
    await MusicService.instance.fetchTracks(offset: itemsCount);
  }

  _playAudioTrack(Track track) {
    mainStore.audioPlayerStore.play(track);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      bool isLoading = mainStore.tracksStore.isLoading;

      if (isLoading && mainStore.tracksStore.tracks.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(
            strokeWidth: 3,
            color: Colors.black,
          ),
        );
      }

      return Container(
        color: Colors.grey.shade100,
        child: Column(
          children: [
            Expanded(
              child: PagedListView<int, Track>(
                pagingController: mainStore.tracksStore.pagingController,
                builderDelegate: PagedChildBuilderDelegate<Track>(
                  itemBuilder: (context, trackItem, index) => GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _playAudioTrack(trackItem),
                    child: TrackListTile(track: trackItem),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
