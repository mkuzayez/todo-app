part of 'todo_items_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class LoadTodos extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final TodoItem todoItem;

  const AddTodoEvent(this.todoItem);

  @override
  List<Object?> get props => [todoItem];
}

class EditTodoEvent extends TodoEvent {
  final TodoItem updatedTodoItem;
  final int index;

  const EditTodoEvent(this.updatedTodoItem, this.index);

  @override
  List<Object> get props => [updatedTodoItem, index];
}

class DeleteTodoEvent extends TodoEvent {
  final TodoItem todoItem;

  const DeleteTodoEvent(this.todoItem);

  @override
  List<Object?> get props => [todoItem];
}

class FilterTodosWithDeadline extends TodoEvent {}

class SortTodosByDate extends TodoEvent {}
