import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/data/model/event.dart';
import 'package:spooker/data/provider/top_provider.dart';

import '../../../data/repository/event/event_repository.dart';

final eventViewModel = ChangeNotifierProvider(
    (ref) => EventViewModel(ref.read(eventRepositoryProvider)));

class EventViewModel extends ChangeNotifier {
  EventViewModel(this._repository);

  final EventRepository _repository;

  String _title = '';

  String get title => _title;

  set title(String text) {
    _title = text;
    notifyListeners();
  }

  String _date = '';

  String get date => _date;

  set date(String text) {
    _date = text;
    notifyListeners();
  }

  String _place = '';

  String get place => _place;

  set place(String text) {
    _place = text;
    notifyListeners();
  }

  String _tag = '';

  set tag(String text) {
    _tag = text;
    notifyListeners();
  }

  bool isDataCompleted() {
    if (_title.isNotEmpty &&
        _date.isNotEmpty &&
        _place.isNotEmpty &&
        _tag.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool _isSaved = false;

  get isSaved => _isSaved;

  Future<void> createNewEvent() async {
    var event = Event(_title, _date, "5:30", _tag, _place);
    return await _repository.createNewEvent(event).then((value) {
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
}
