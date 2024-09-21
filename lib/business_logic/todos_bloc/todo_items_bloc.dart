import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/data/todo_repository.dart';
import 'package:todo_app/data/models/todo_item/to_do.dart';

part 'todo_items_event.dart';
part 'todo_items_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;

  TodoBloc(this.todoRepository) : super(TodoLoading()) {
    on<LoadTodos>(loadTodos);
    on<AddTodoEvent>(addTodo);
    on<EditTodoEvent>(editTodo);
    on<DeleteTodoEvent>(deleteTodo);
    on<FilterTodosWithDeadline>(filterTodosWithDeadline);
    on<SortTodosByDate>(sortTodosByDate);
  }

  Future<void> loadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    final todos = await todoRepository.loadItems();
    if (todos.isEmpty) {
      emit(
        const TodoNotFound(
          'No todo items found',
        ),
      );
    } else {
      emit(
        TodoLoaded(
          List.from(todos),
        ),
      );
    }
  }

  Future<void> addTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    await todoRepository.addItem(event.todoItem);
    final todos = await todoRepository.loadItems();
    emit(
      TodoLoaded(
        List.from(todos),
      ),
    );
  }

  Future<void> editTodo(EditTodoEvent event, Emitter<TodoState> emit) async {
    await todoRepository.editItem(event.updatedTodoItem, event.index);
    final todos = await todoRepository.loadItems();
    emit(
      TodoLoaded(
        List.from(todos),
      ),
    );
  }

  Future<void> deleteTodo(
      DeleteTodoEvent event, Emitter<TodoState> emit) async {
    await todoRepository.deleteItem(event.todoItem);
    final todos = await todoRepository.loadItems();
    if (todos.isEmpty) {
      emit(
        const TodoNotFound(
          'No todo items found',
        ),
      );
    } else {
      emit(
        TodoLoaded(
          List.from(
            todos,
          ),
        ),
      );
    }
  }

  Future<void> filterTodosWithDeadline(
      FilterTodosWithDeadline event, Emitter<TodoState> emit) async {
    final todos = await todoRepository.loadItems();
    final filteredTodos = todos.where((todo) => todo.deadline != null).toList();

    if (filteredTodos.isEmpty) {
      emit(
        const TodoNotFound(
          'No todos with a deadline found',
        ),
      );
    } else {
      emit(
        TodoLoaded(
          List.from(
            filteredTodos,
          ),
        ),
      );
    }
  }

  Future<void> sortTodosByDate(
      SortTodosByDate event, Emitter<TodoState> emit) async {
    final todos = await todoRepository.loadItems();

    todos.sort((a, b) => a.date.compareTo(b.date));

    if (todos.isEmpty) {
      emit(
        const TodoNotFound(
          'No todo items found',
        ),
      );
    } else {
      emit(
        TodoLoaded(
          List.from(todos),
        ),
      );
    }
  }
}
