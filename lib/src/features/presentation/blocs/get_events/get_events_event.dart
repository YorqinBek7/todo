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
