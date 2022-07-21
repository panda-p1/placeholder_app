class Photo {
  final int albumId;
  final int id;
  final String title;
  final String photoUrl;
  final String miniPhotoUrl;

  const Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.photoUrl,
    required this.miniPhotoUrl,
  });
}