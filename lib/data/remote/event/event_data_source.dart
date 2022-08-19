import 'package:spooker/data/model/event.dart';

abstract class EventDataSource {
  Future<List<Event>> getEvents();

  Future<List<Event>> getMyEvents();

  Future<void> createNewEvent(Event event);

  Future<void> deleteEvent(String eventId);

  Future<void> updateEvent(Event event);

  Future<List<Event>> getUserEvents(String userId);
}
