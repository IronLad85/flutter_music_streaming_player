import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mobx/mobx.dart';
import 'package:music_player/models/tracks.dart';

part 'tracks_store.g.dart';

class TrackStore = _TracksStore with _$TrackStore;

abstract class _TracksStore with Store {
  @observable
  ObservableList<Track> tracks = ObservableList<Track>();

  final PagingController<int, Track> pagingController =
      PagingController(firstPageKey: 0);

  @observable
  bool isLoading = false;

  @action
  void setTracks(List<Track> newTracks) {
    tracks = ObservableList.of([...tracks, ...newTracks]);
    pagingController.appendPage(newTracks, newTracks.length);
  }

  @action
  void setLoading(bool value) {
    isLoading = value;
  }
}
