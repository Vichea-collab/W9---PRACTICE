import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/artists/artist.dart';
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';

class ArtistRepositoryFirebase extends ArtistRepository {
  final Uri artistsUri = Uri.https(
    'w9-database-be79e-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/artists.json',
  );

  @override
  Future<List<Artist>> fetchArtists() async {
    final http.Response response = await http.get(artistsUri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> artistJson =
          json.decode(response.body) as Map<String, dynamic>;

      return artistJson.entries.map((entry) {
        final Map<String, dynamic> artistData = Map<String, dynamic>.from(
          entry.value as Map,
        );
        artistData[ArtistDto.idKey] = entry.key;
        return ArtistDto.fromJson(artistData);
      }).toList();
    } else {
      throw Exception('Failed to load artists');
    }
  }
}
