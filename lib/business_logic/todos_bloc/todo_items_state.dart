part of 'todo_items_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object?> get props => [];
}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<TodoItem> todos;

  const TodoLoaded(this.todos);

  @override
  List<Object?> get props => [todos];
}

class TodoNotFound extends TodoState {
  final String message;

  const TodoNotFound(this.message);

  @override
  List<Object?> get props => [message];
}

class TodoUpdated extends TodoState {}
