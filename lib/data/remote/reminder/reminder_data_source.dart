import '../../model/reminder.dart';

abstract class ReminderDataSource {
  Future<List<Reminder>> getReminders();

  Future<void> createNewReminder(Reminder reminder);

  Future<void> updateReminder(Reminder reminder);

  Future<void> deleteReminder(String reminderId);
}
