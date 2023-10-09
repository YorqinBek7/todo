import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/features/data/models/todo/todo_model.dart';
import 'package:todo/src/features/data/repository/event_repository.dart';

part 'events_for_calendar_event.dart';
part 'events_for_calendar_state.dart';

class EventsForCalendarBloc extends Bloc<GetEventEvent, GetEventState> {
  final EventRepository _eventRepository;
  EventsForCalendarBloc(this._eventRepository)
      : super(const EventsForCalendarLoading()) {
    on<EventsForCalendarEvent>(onGetTodosEvent);
  }
  void onGetTodosEvent(
      EventsForCalendarEvent event, Emitter<GetEventState> emit) async {
    emit(const EventsForCalendarLoading());
    try {
      List<TodoModel> todoList = await _eventRepository.getTodos();
      emit(
        EventsForCalendarSuccess(todoList),
      );
    } catch (e) {
      emit(
        EventsForCalendarFailure(e.toString()),
      );
    }
  }
}
