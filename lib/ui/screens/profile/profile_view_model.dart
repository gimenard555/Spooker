import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/data/model/user.dart';

import '../../../data/model/artwork.dart';
import '../../../data/model/event.dart';
import '../../../data/model/result.dart';
import '../../../data/provider/top_provider.dart';
import '../../../data/repository/artwork/artwork_repository.dart';
import '../../../data/repository/auth/auth_repository.dart';
import '../../../data/repository/event/event_repository.dart';

final profileViewModel = ChangeNotifierProvider((ref) => ProfileViewModel(
    ref.read(artworkRepositoryProvider),
    ref.read(eventRepositoryProvider),
    ref.read(authRepositoryProvider)));

class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel(this._artworkRepo, this._eventsRepo, this._repository);

  final ArtworkRepository _artworkRepo;
  final EventRepository _eventsRepo;
  final AuthRepository _repository;

  SpookerUser? _user;

  SpookerUser? get user => _user;
  Result<List<Artwork>>? _artworks;
  Result<List<Event>>? _events;

  Result<List<Artwork>>? get artworks => _artworks;

  Result<List<Event>>? get events => _events;

  String myImage = '';

  bool _isSignOut = false;

  bool get isLogOut => _isSignOut;

  Future<void> getArtworks({String userId = ''}) {
    if (userId.isEmpty) {
      return _artworkRepo
          .fetchMyArtworks()
          .then((value) => _artworks = value)
          .whenComplete(notifyListeners);
    } else {
      return _artworkRepo
          .fetchUserArtworks(userId)
          .then((value) => _artworks = value)
          .whenComplete(notifyListeners);
    }
  }

  Future<void> getEvents({String userId = ''}) {
    if (userId.isEmpty) {
      return _eventsRepo
          .getMyEvents()
          .then((value) => _events = value)
          .whenComplete(notifyListeners);
    } else {
      return _eventsRepo
          .fetchUserEvents(userId)
          .then((value) => _events = value)
          .whenComplete(notifyListeners);
    }
  }

  Future<void> getProfile({String profileId = ''}) async {
    if (profileId.isEmpty) {
      await _repository.getCurrentUserData().then((value) {
        if (value.isSuccess) {
          value.ifSuccess((data) => _user = data);
          notifyListeners();
        } else if (value.isFailure) {
          value.ifFailure((data) {
            _user = null;
            notifyListeners();
          });
        }
      });
    } else {
      await _repository.getOtherUserData(profileId).then((value) {
        if (value.isSuccess) {
          value.ifSuccess((data) => _user = data);
          notifyListeners();
        } else if (value.isFailure) {
          value.ifFailure((data) {
            _user = null;
            notifyListeners();
          });
        }
      });
    }
  }

  Future<void> updatePassword() async {}

  Future<void> logOut() async {
    await _repository.signOut().then((value) {
      if (value.isSuccess) {
        _isSignOut = true;
        _user = null;
        notifyListeners();
      } else if (value.isFailure) {
        value.ifFailure((data) {
          _isSignOut = false;
          notifyListeners();
        });
      }
    });
  }
}
