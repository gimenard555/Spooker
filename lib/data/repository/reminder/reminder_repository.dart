import '../../model/reminder.dart';
import '../../model/result.dart';

abstract class ReminderRepository {
  Future<Result<List<Reminder>>> getReminders();

  Future<Result<void>> createNewReminder(Reminder reminder);

  Future<Result<void>> updateReminder(Reminder reminder);

  Future<Result<void>> deleteReminder(Reminder reminder);
}
