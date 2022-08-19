import '../../model/artwork.dart';

abstract class ArtworkDataSource {
  Future<List<Artwork>> fetchArtworks();

  Future<List<Artwork>> fetchMyArtworks();

  Future<void> createNewArtwork(Artwork artwork);

  Future<void> deleteArtwork(String artworkId);

  Future<void> updateArtwork(Artwork artwork);

  Future<List<Artwork>> fetchUserArtworks(String userId);
}
