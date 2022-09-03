import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:spooker/data/provider/top_provider.dart';

import '../../../data/model/reminder.dart';
import '../../../data/model/result.dart';
import '../../../data/repository/reminder/reminder_repository.dart';
import '../../utils/spooker_strings.dart';

final reminderViewModelProvider = ChangeNotifierProvider(
    (ref) => ReminderViewModel(ref.read(reminderRepositoryProvider)));

class ReminderViewModel extends ChangeNotifier {
  ReminderViewModel(this._repository);

  String _title = SpookerStrings.EMPTY;

  String get title => _title;

  set title(String text) {
    _title = text;
    notifyListeners();
  }

  String _date = SpookerStrings.EMPTY;

  String get date => _date;

  DateTime dateTime = DateTime.now();

  set date(String text) {
    _date = text;
    notifyListeners();
  }

  String _hour = SpookerStrings.EMPTY;

  String get hour => _hour;

  set hour(String text) {
    _hour = text;
    notifyListeners();
  }

  String _place = SpookerStrings.EMPTY;

  String get place => _place;

  set place(String text) {
    _place = text;
    notifyListeners();
  }

  String selectedDate = SpookerStrings.EMPTY;

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
    return await _repository.createNewReminder(createReminder()).then((value) {
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

  Future<void> deleteReminder(String reminderId) async {
    await _repository.deleteReminder(reminderId).then((value) {
      if (value.isSuccess) {
        notifyListeners();
      }
    });
  }

  Future<void> editReminder(String reminderId) async {
    await _repository
        .updateReminder(createReminder(idReminder: reminderId))
        .then((value) {
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

  Reminder createReminder({String idReminder = SpookerStrings.EMPTY}) {
    DateFormat format = DateFormat(SpookerStrings.lastDateFormat);
    return Reminder(
        _date, _title, _hour, false, format.parse('$selectedDate $hour'), _place,
        id: idReminder);
  }

  void chargeReminderData(Reminder reminder) {
    _date = reminder.date;
    _title = reminder.description;
    _hour = reminder.hour;
    _place = reminder.place;
    isDataCompleted();
  }
}
