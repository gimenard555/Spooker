import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/data/model/artwork.dart';
import 'package:spooker/data/model/event.dart';
import 'package:spooker/data/model/result.dart';
import 'package:spooker/data/repository/artwork/artwork_repository.dart';
import 'package:spooker/data/repository/event/event_repository.dart';
import '../../../data/provider/top_provider.dart';

final dashboardViewModelProvider = ChangeNotifierProvider((ref) =>
    DashboardViewModel(ref.read(artworkRepositoryProvider),
        ref.read(eventRepositoryProvider)));

class DashboardViewModel extends ChangeNotifier {
  DashboardViewModel(this._artworkRepo, this._eventsRepo);

  final ArtworkRepository _artworkRepo;
  final EventRepository _eventsRepo;

  Result<List<Artwork>>? _artworks;
  Result<List<Event>>? _events;

  Result<List<Artwork>>? get artworks => _artworks;

  Result<List<Event>>? get events => _events;

  Future<void> fetchArtworks() {
    return _artworkRepo
        .fetchArtworks()
        .then((value) => _artworks = value)
        .whenComplete(notifyListeners);
  }

  Future<void> fetchEvents() {
    return _eventsRepo
        .getEvents()
        .then((value) => _events = value)
        .whenComplete(notifyListeners);
  }
}
