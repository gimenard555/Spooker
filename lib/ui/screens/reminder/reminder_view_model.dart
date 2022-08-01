import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/data/provider/top_provider.dart';

import '../../../data/model/reminder.dart';
import '../../../data/model/result.dart';
import '../../../data/repository/reminder/reminder_repository.dart';

final reminderViewModelProvider = ChangeNotifierProvider(
    (ref) => ReminderViewModel(ref.read(reminderRepositoryProvider)));

class ReminderViewModel extends ChangeNotifier {
  ReminderViewModel(this._repository);

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

  String _hour = '';

  String get hour => _hour;

  set hour(String text) {
    _hour = text;
    notifyListeners();
  }

  String _place = '';

  String get place => _place;

  set place(String text) {
    _place = text;
    notifyListeners();
  }

  String selectedDate = '';

  final ReminderRepository _repository;
  Result<List<Reminder>>? _reminders;

  Result<List<Reminder>>? get reminders => _reminders;

  Future<void> fetchReminders() {
    return _repository
        .getReminders()
        .then((value) => _reminders = value)
        .whenComplete(notifyListeners);
  }

  bool isDataCompleted() {
    if (_title.isNotEmpty && _date.isNotEmpty && _hour.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool _isSaved = false;

  get isSaved => _isSaved;

  Future<void> createNewEvent() async {
    final finalDate = DateTime.now();
    var reminder = Reminder(_date, _title, _hour, true, finalDate);
    return await _repository.createNewReminder(reminder).then((value) {
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
