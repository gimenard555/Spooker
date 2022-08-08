import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/data/model/artwork.dart';
import 'package:spooker/data/provider/top_provider.dart';

import '../../../data/repository/artwork/artwork_repository.dart';

final artworkViewModel = ChangeNotifierProvider(
    (ref) => ArtworkViewModel(ref.read(artworkRepositoryProvider)));

class ArtworkViewModel extends ChangeNotifier {
  ArtworkViewModel(this._repository);

  final ArtworkRepository _repository;

  String _title = '';

  String get title => _title;

  set title(String text) {
    _title = text;
    notifyListeners();
  }

  String _description = '';

  String get description => _description;

  set description(String text) {
    _description = text;
    notifyListeners();
  }

  String _file = '';

  String get file => _file;

  set file(String text) {
    _file = text;
    notifyListeners();
  }

  String _privacy = '';

  String get privacy => _privacy;

  set privacy(String text) {
    _privacy = text;
    notifyListeners();
  }

  bool _isSaved = false;

  get isSaved => _isSaved;

  bool isDataCompleted() {
    if (_title.isNotEmpty &&
        _description.isNotEmpty &&
        _file.isNotEmpty &&
        _privacy.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> createNewArtwork() async {
    return await _repository.createNewArtwork(getArtwork()).then((value) {
      if (value.isSuccess) {
        value.ifSuccess((flag) => _isSaved = true);
        notifyListeners();
      } else if (value.isFailure) {
        value.ifFailure((data) {
          _isSaved = false;
          notifyListeners();
        });
      }
    });
  }

  Artwork getArtwork() {
    return Artwork(_title, _file, _description, _privacy);
  }

  void deleteArtwork() {}

  void updateArtwork() {}
}
