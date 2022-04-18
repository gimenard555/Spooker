import 'package:spooker/data/model/artwork.dart';
import 'package:spooker/data/model/result.dart';
import 'package:spooker/data/repository/artwork/artwork_repository.dart';

import '../../remote/artwork/artwork_data_source.dart';

class ArtworkRepositoryImpl extends ArtworkRepository {
  ArtworkRepositoryImpl(this._dataSource);

  final ArtworkDataSource _dataSource;

  @override
  Future<void> createNewArtwork() async {}


  @override
  Future<Result<List<Artwork>>> fetchArtworks() async {
    return Result.guardFuture(() => _dataSource.fetchArtworks());
  }

  @override
  Future<void> deleteArtwork() {
    // TODO: implement deleteArtwork
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Artwork>>> fetchMyArtworks() {
    // TODO: implement fetchMyArtworks
    throw UnimplementedError();
  }
}
