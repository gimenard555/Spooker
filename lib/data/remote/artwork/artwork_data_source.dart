import '../../model/artwork.dart';

abstract class ArtworkDataSource {
  Future<List<Artwork>> fetchArtworks();

  Future<void> createNewArtwork();

  Future<void> deleteNewArtwork();
}
