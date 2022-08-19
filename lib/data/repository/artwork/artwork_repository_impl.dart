import 'package:spooker/data/model/artwork.dart';
import 'package:spooker/data/model/result.dart';
import 'package:spooker/data/repository/artwork/artwork_repository.dart';

import '../../remote/artwork/artwork_data_source.dart';

class ArtworkRepositoryImpl extends ArtworkRepository {
  ArtworkRepositoryImpl(this._dataSource);

  final ArtworkDataSource _dataSource;

  @override
  Future<Result<void>> createNewArtwork(Artwork artwork) async {
    return Result.guardFuture(() => _dataSource.createNewArtwork(artwork));
  }

  @override
  Future<Result<List<Artwork>>> fetchArtworks() async {
    return Result.guardFuture(() => _dataSource.fetchArtworks());
  }

  @override
  Future<Result<void>> deleteArtwork(String artworkId) {
    return Result.guardFuture(() => _dataSource.deleteArtwork(artworkId));
  }

  @override
  Future<Result<List<Artwork>>> fetchMyArtworks() {
    return Result.guardFuture(() => _dataSource.fetchMyArtworks());
  }

  @override
  Future<Result<void>> updateArtwork(Artwork artwork) {
    return Result.guardFuture(() => _dataSource.updateArtwork(artwork));
  }

  @override
  Future<Result<List<Artwork>>> fetchUserArtworks(String userId) {
    return Result.guardFuture(() => _dataSource.fetchUserArtworks(userId));
  }
}
