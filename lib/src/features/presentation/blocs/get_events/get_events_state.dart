part of 'get_events_bloc.dart';

sealed class GetEventsState extends Equatable {
  const GetEventsState();

  @override
  List<Object> get props => [];
}

final class GetEventsLoading extends GetEventsState {
  const GetEventsLoading();
  @override
  List<Object> get props => [];
}

final class GetEventsSuccess extends GetEventsState {
  const GetEventsSuccess({
    required this.todosModel,
  });
  final List<TodoModel> todosModel;

  @override
  List<Object> get props => [todosModel];
}

final class GetEventsFailure extends GetEventsState {
  const GetEventsFailure(this.errorMessage);
  final String errorMessage;
  @override
  List<Object> get props => [
        errorMessage,
      ];
}
