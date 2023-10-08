import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/features/data/models/todo/todo_model.dart';
import 'package:todo/src/features/data/repository/event_repository.dart';

part 'get_events_event.dart';
part 'get_events_state.dart';

class GetEventsBloc extends Bloc<GetEventsEvent, GetEventsState> {
  final EventRepository eventRepository;
  GetEventsBloc(this.eventRepository) : super(const GetEventsLoading()) {
    on<GetTodosEvent>(onGetTodosEvent);
  }
  void onGetTodosEvent(
      GetTodosEvent event, Emitter<GetEventsState> emit) async {
    emit(const GetEventsLoading());
    try {
      List<TodoModel> todoList = await eventRepository.getTodos();
      emit(
        GetEventsSuccess(
          todosModel: todoList,
        ),
      );
    } catch (e) {
      emit(
        GetEventsFailure(e.toString()),
      );
    }
  }
}
