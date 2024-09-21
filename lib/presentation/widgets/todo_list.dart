import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/business_logic/todos_bloc/todo_items_bloc.dart';
import 'package:todo_app/data/models/todo_item/to_do.dart';

import 'todo_card.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  void undoDelete(TodoItem item) {
    context.read<TodoBloc>().add(
          AddTodoEvent(item),
        );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Item restored.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is TodoLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TodoLoaded) {
          return ListView.builder(
            itemCount: state.todos.length,
            itemBuilder: (context, index) {
              final todo = state.todos[index];
              return TodoCard(
                undoDelete,
                index: index,
                item: todo,
              );
            },
          );
        } else if (state is TodoNotFound) {
          return Center(child: Text(state.message));
        } else {
          return const Center(
            child: Text("FATAL ERROR!"),
          );
        }
      },
    );
  }
}
