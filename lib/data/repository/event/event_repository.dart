import '../../model/event.dart';
import '../../model/result.dart';

abstract class EventRepository {
  Future<Result<List<Event>>> getEvents();

  Future<Result<void>>  createNewEvent(Event event);
}
