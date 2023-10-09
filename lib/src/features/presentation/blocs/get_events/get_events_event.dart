part of 'get_events_bloc.dart';

sealed class GetEventsEvent extends Equatable {
  const GetEventsEvent();

  @override
  List<Object> get props => [];
}

final class GetTodosEvent extends GetEventsEvent {
  const GetTodosEvent();
  @override
  List<Object> get props => [];
}

final class AddTodoEvent extends GetEventsEvent {
  const AddTodoEvent(this.todoModel);
  final TodoModel todoModel;
  @override
  List<Object> get props => [todoModel];
}

final class RemoveTodoByIdEvent extends GetEventsEvent {
  const RemoveTodoByIdEvent(this.id);
  final int id;
  @override
  List<Object> get props => [
        id,
      ];
}

final class EditTodoById extends GetEventsEvent {
  const EditTodoById({
    required this.id,
    required this.todoModel,
  });

  final TodoModel todoModel;
  final int id;

  @override
  List<Object> get props => [
        id,
        todoModel,
      ];
}
