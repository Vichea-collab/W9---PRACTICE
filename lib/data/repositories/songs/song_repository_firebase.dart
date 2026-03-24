import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  final Uri songsUri = Uri.https(
    'w9-database-be79e-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/songs.json',
  );

  @override
  Future<List<Song>> fetchSongs() async {
    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> songJson =
          json.decode(response.body) as Map<String, dynamic>;

      return songJson.entries.map((entry) {
        final Map<String, dynamic> songData = Map<String, dynamic>.from(
          entry.value as Map,
        );
        songData[SongDto.idKey] = entry.key;
        return SongDto.fromJson(songData);
      }).toList();
    } else {
      throw Exception('Failed to load songs');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {}
}
