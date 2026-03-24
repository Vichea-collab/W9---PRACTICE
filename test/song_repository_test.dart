import 'package:w9_song/data/repositories/songs/song_repository.dart';
import 'package:w9_song/data/repositories/songs/song_repository_firebase.dart';
import 'package:w9_song/model/songs/song.dart';

void main() async {
  //   Instantiate the  song_repository_mock
  SongRepository songRepository = SongRepositoryFirebase();

  List<Song> songs = await songRepository.fetchSongs();
  songs.toString();
}
