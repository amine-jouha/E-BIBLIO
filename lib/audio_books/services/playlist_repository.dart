import '../data_podcast.dart';

abstract class PlaylistRepository {
  Future<List<Map<String, String>>> fetchInitialPlaylist();
  Future<Map<String, String>> fetchAnotherSong();
}

class DemoPlaylist extends PlaylistRepository {
  @override
  Future<List<Map<String, String>>> fetchInitialPlaylist(
      {int length = 9}) async {
    return List.generate(length, (index) => _nextSong());
  }

  @override
  Future<Map<String, String>> fetchAnotherSong() async {
    return _nextSong();
  }

  var _songIndex = 0;
  var _maxSongNumber = allPdItemsContent.length;

  Map<String, String> _nextSong() {
    _songIndex = (_songIndex % _maxSongNumber) + 1;
    return {
      'id': _songIndex.toString().padLeft(3, '0'),
      'title': 'e-Biblio AudioBook $_songIndex',
      'album': 'e-Biblio',
      'description' : allPdItemsContent[_songIndex].title,
      // 'image':allPdItemsContent[_songIndex].image,
      'url':
      allPdItemsContent[_songIndex].url[0],
      //     'https://www.radioj.fr/podcast-player/14000$_songIndex/edition-speciale-terrorisme-en-israel-attentat-de-bnei-brak-2.mp3?_=3',
    };
  }
}
