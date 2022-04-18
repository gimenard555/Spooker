import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../data/model/artwork.dart';
import '../../../data/model/result.dart';
import '../../../data/provider/top_provider.dart';
import '../../../data/repository/artwork/artwork_repository.dart';
import '../../../data/repository/event/event_repository.dart';

final profileViewModel = ChangeNotifierProvider((ref) => ProfileViewModel(
    ref.read(artworkRepositoryProvider), ref.read(eventRepositoryProvider)));

class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel(this._artworkRepo, this._eventsRepo);

  final ArtworkRepository _artworkRepo;
  final EventRepository _eventsRepo;

  Result<List<Artwork>>? _artworks;
  Result<List<Event>>? _events;

  Result<List<Artwork>>? get artworks => _artworks;

  Result<List<Event>>? get events => _events;

  Future<void> getMyArtworks() {
    return _artworkRepo
        .fetchArtworks()
        .then((value) => _artworks = value)
        .whenComplete(notifyListeners);
  }

  Future<void> getMyEvents() {
    return _artworkRepo
        .fetchArtworks()
        .then((value) => _artworks = value)
        .whenComplete(notifyListeners);
  }
}
