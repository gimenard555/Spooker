import 'package:spooker/data/model/event.dart';

abstract class EventDataSource {
  Future<List<Event>> getEvents();

  Future<void> createNewEvent(Event event);
}
