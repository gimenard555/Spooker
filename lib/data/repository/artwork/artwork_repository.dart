import 'package:spooker/data/model/artwork.dart';
import '../../model/result.dart';

abstract class ArtworkRepository {
  Future<Result<List<Artwork>>> fetchArtworks();

  Future<Result<void>> createNewArtwork(Artwork artwork);

  Future<Result<void>> deleteArtwork(String artworkId);

  Future<Result<void>> updateArtwork(Artwork artwork);

  Future<Result<List<Artwork>>> fetchMyArtworks();

  Future<Result<List<Artwork>>> fetchUserArtworks(String userId);
}
