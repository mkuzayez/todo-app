part of 'todo_item_cubit.dart';

class SelectedTodoState extends Equatable {
  final TodoItem? todoItem;
  final int? index;

  const SelectedTodoState({this.todoItem, this.index});

  @override
  List<Object?> get props => [todoItem, index];
}