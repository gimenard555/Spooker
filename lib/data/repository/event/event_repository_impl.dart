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
}
