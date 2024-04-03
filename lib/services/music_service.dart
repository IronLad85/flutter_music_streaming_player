import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_player/models/tracks.dart';
import 'package:music_player/store/main_store.dart';

class MusicService {
  final String _baseUrl = 'https://api.jamendo.com/v3.0';
  final String _clientId = 'e1728b99';
  late MainStore mainStore;

  static final MusicService instance = MusicService._internal();
  MusicService._internal();

  void setMainStoreReference(MainStore mainStoreReference) {
    mainStore = mainStoreReference;
  }

  Future<dynamic> _callApi(
    String endpoint, {
    int limit = 10,
    int offset = 0,
    Map<String, String>? params,
  }) async {
    final queryParameters = {
      'client_id': _clientId,
      'limit': limit.toString(),
      'offset': offset.toString(),
      'order': 'popularity_month',
      ...?params,
    };

    final uri = Uri.parse('$_baseUrl$endpoint').replace(
      queryParameters: queryParameters,
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.reasonPhrase}');
    }
  }

  Future<dynamic> fetchTracks({
    String? artistName,
    int limit = 20,
    int offset = 0,
  }) async {
    mainStore.tracksStore.setLoading(true);
    try {
      final params = artistName != null ? {'artist_name': artistName} : null;

      var data = await _callApi(
        '/tracks',
        params: params,
        limit: limit,
        offset: offset,
      );

      List<Track> list = (data['results'] as List? ?? []).map((trackData) {
        return Track.fromJson(trackData);
      }).toList();

      mainStore.tracksStore.setTracks(list);
    } catch (error) {
      print(error);
    } finally {
      mainStore.tracksStore.setLoading(false);
    }
  }
}
