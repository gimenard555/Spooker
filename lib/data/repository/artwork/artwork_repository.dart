import 'package:spooker/data/model/artwork.dart';
import '../../model/result.dart';

abstract class ArtworkRepository {
  Future<Result<List<Artwork>>> fetchArtworks();

  Future<void> createNewArtwork();

  Future<void> deleteArtwork();

  Future<Result<List<Artwork>>> fetchMyArtworks();
}
