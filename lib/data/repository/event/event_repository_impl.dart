import 'package:spooker/data/model/event.dart';
import 'package:spooker/data/repository/event/event_repository.dart';

import '../../model/result.dart';
import '../../remote/event/event_data_source.dart';

class EventRepositoryImpl extends EventRepository {
  EventRepositoryImpl(this._dataSource);

  final EventDataSource _dataSource;

  @override
  Future<Result<List<Event>>> getEvents() async {
    return Result.guardFuture(() => _dataSource.getEvents());
  }

  @override
  Future<Result<void>> createNewEvent(Event event) {
    return Result.guardFuture(() => _dataSource.createNewEvent(event));
  }

  @override
  Future<Result<void>> deleteEvent(String eventId) {
    return Result.guardFuture(() => _dataSource.deleteEvent(eventId));
  }

  @override
  Future<Result<List<Event>>> getMyEvents() {
    return Result.guardFuture(() => _dataSource.getMyEvents());
  }

  @override
  Future<Result<void>> updateEvent(Event event) {
    return Result.guardFuture(() => _dataSource.updateEvent(event));
  }

  @override
  Future<Result<List<Event>>> fetchUserEvents(String userId) {
    return Result.guardFuture(() => _dataSource.getUserEvents(userId));
  }
}
