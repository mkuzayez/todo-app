import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/data/models/todo_item/to_do.dart';

part 'todo_item_state.dart';

class SelectedTodoCubit extends Cubit<SelectedTodoState> {
  SelectedTodoCubit() : super(const SelectedTodoState());

  void updateSelectedTodo(TodoItem item, int index) {
    emit(SelectedTodoState(todoItem: item, index: index));
  }

  void clearSelectedTodo() {
    emit(const SelectedTodoState());
  }
}
