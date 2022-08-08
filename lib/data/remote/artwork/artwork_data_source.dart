import '../../model/artwork.dart';

abstract class ArtworkDataSource {
  Future<List<Artwork>> fetchArtworks();

  Future<List<Artwork>> fetchMyArtworks();

  Future<void> createNewArtwork(Artwork artwork);

  Future<void> deleteNewArtwork(String artworkId);

  Future<void> updateArtwork(Artwork artwork);
}
