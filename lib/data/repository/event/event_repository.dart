import '../../model/event.dart';
import '../../model/result.dart';

abstract class EventRepository {
  Future<Result<List<Event>>> getEvents();

  Future<Result<List<Event>>> getMyEvents();

  Future<Result<void>> createNewEvent(Event event);

  Future<Result<void>> deleteEvent(String eventId);

  Future<Result<void>> updateEvent(Event event);
}
