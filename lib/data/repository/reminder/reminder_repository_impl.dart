import 'package:spooker/data/model/reminder.dart';
import 'package:spooker/data/model/result.dart';
import 'package:spooker/data/repository/reminder/reminder_repository.dart';

import '../../remote/reminder/reminder_data_source.dart';

class ReminderRepositoryImpl extends ReminderRepository {
  ReminderRepositoryImpl(this._dataSource);

  final ReminderDataSource _dataSource;

  @override
  Future<Result<void>> createNewReminder(Reminder reminder) {
    return Result.guardFuture(() => _dataSource.createNewReminder(reminder));
  }

  @override
  Future<Result<void>> deleteReminder(Reminder reminder) {
    return Result.guardFuture(() => _dataSource.deleteReminder(reminder));
  }

  @override
  Future<Result<List<Reminder>>> getReminders() {
    return Result.guardFuture(() => _dataSource.getReminders());
  }

  @override
  Future<Result<void>> updateReminder(Reminder reminder) {
    return Result.guardFuture(() => _dataSource.updateReminder(reminder));
  }
}
