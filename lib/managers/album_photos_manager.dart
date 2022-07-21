import 'package:placeholder_app/api/photo_provider/managers/get_photos.dart';
import 'package:placeholder_app/data/album/album.dart';
import 'package:placeholder_app/data/photo/photo.dart';

class AlbumPhotoManagerListener {
  final AlbumPhotoListenerUpdateFunc update;
  final Album album;

  const AlbumPhotoManagerListener(this.update, this.album);
}

typedef AlbumPhotoListenerUpdateFunc = void Function(List<Photo> photos);

class AlbumPhotosManager {
  final List<Album> albums;
  AlbumPhotosManager(this.albums,);

  List<Photo>? _photos;

  final List<AlbumPhotoManagerListener> _listeners = [];
  final List<Album> _loadedAlbums = [];

  List<int> get _loadedAlbumsIds => _loadedAlbums.map((album) => album.id).toList();

  bool isAlbumLoaded(Album album) => _loadedAlbumsIds.any((albumId) => albumId == album.id);

  void addLoadListener(Album album,
      AlbumPhotoListenerUpdateFunc update,
      {bool notifyIfAlreadyLoaded = true}
  ) {
    _listeners.add(AlbumPhotoManagerListener(
      update,
      album,
    ));

    if(!notifyIfAlreadyLoaded) {
      return;
    }

    if(!isAlbumLoaded(album)) {
      return;
    }

    _notify([album]);
  }

  void removeListener(AlbumPhotoListenerUpdateFunc updateFunc) {
    _listeners.removeWhere((listener) => listener.update == updateFunc);
  }

  void addAlbums(List<Album> albums) {
    final albumsIds = this.albums.map((album) => album.id).toList();

    for(var album in albums) {
      if(!albumsIds.contains(album.id)) {
        this.albums.add(album);
      }
    }
  }

  void loadPhotos() async {
    final loadingAlbums = albums;
    final notLoadedAlbums = loadingAlbums.where((album) => !_loadedAlbumsIds.contains(album.id)).toList();

    final response = await GetPhotosNetManager(notLoadedAlbums).getPhotos();
    if(response.isFail()) {
      return;
    }
    _photos = [...(_photos ?? <Photo>[]), ...response.content!];
    _addLoadedAlbums(notLoadedAlbums);
    _notify(notLoadedAlbums);
  }

  void _addLoadedAlbums(List<Album> albums) {
    _loadedAlbums.addAll(albums);
  }

  void _notify(List<Album> albums) {
    final relevantListeners = _listeners
        .where((listener) => albums.map((album) => album.id)
        .contains(listener.album.id));

    for (var listener in relevantListeners) {
      final photos = _photos!.where((photo) => photo.albumId == listener.album.id).toList();
      listener.update(photos);
    }
  }
}