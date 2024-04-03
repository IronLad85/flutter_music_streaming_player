import 'package:mobx/mobx.dart';
import 'package:music_player/store/audio_player/audio_player_store.dart';
import 'package:music_player/store/tracks/tracks_store.dart';

// Include generated file
part 'main_store.g.dart';

class MainStore extends _MainStore with _$MainStore {}

abstract class _MainStore with Store {
  TrackStore tracksStore = TrackStore();
  AudioPlayerStore audioPlayerStore = AudioPlayerStore();
}
