import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/data/model/artwork.dart';
import 'package:spooker/data/model/result.dart';
import 'package:spooker/data/repository/artwork/artwork_repository.dart';
import '../../../data/provider/top_provider.dart';

final dashboardViewModelProvider = ChangeNotifierProvider(
    (ref) => DashboardViewModel(ref.read(artworkRepositoryProvider)));

class DashboardViewModel extends ChangeNotifier {
  DashboardViewModel(this._repository);

  //Events Repository
  final ArtworkRepository _repository;

  //Result Case O
  Result<List<Artwork>>? _artworks;

  Result<List<Artwork>>? get artworks => _artworks;

  Future<void> fetchArtworks() {
    return _repository
        .fetchArtworks()
        .then((value) => _artworks = value)
        .whenComplete(notifyListeners);
  }
}
