import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/business_logic/todo_item_cubit/todo_item_cubit.dart';
import 'package:todo_app/business_logic/todos_bloc/todo_items_bloc.dart';
import 'package:todo_app/presentation/custom_widgets/custom_text.dart';
import 'package:todo_app/presentation/custom_widgets/large_button.dart';
import 'package:todo_app/presentation/sheets/edit_todo.dart';
import 'package:todo_app/presentation/styling/tooltip_shape.dart';
import 'package:todo_app/theme/text.dart';

class TodoDetailsScreen extends StatefulWidget {
  final SelectedTodoCubit selectedTodoCubit;

  const TodoDetailsScreen({
    super.key,
    required this.selectedTodoCubit,
  });

  @override
  State<TodoDetailsScreen> createState() => _TodoDetailsScreenState();
}

class _TodoDetailsScreenState extends State<TodoDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.selectedTodoCubit,
      child: BlocBuilder<SelectedTodoCubit, SelectedTodoState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: todoDetailsAppBar(state, context),
            body: todoBody(state),
          );
        },
      ),
    );
  }
}

Widget todoBody(SelectedTodoState state) {
  return Stack(
    alignment: Alignment.center,
    fit: StackFit.expand,
    children: [
      Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: state.todoItem!.title,
                style: customTextTheme.headlineMedium!,
                color: Colors.black,
              ),
              const SizedBox(height: 10),
              if (state.todoItem!.image != null)
                todoImage(state.todoItem!.image!),
              const SizedBox(height: 10),
              AppText(
                text: state.todoItem!.description,
                maxLine: 1000,
                style: customTextTheme.bodyLarge!,
                color: Colors.black,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      Positioned(
        bottom: 12,
        child: AppText(
          text: 'Created at ${state.todoItem!.formattedDate}',
          style: customTextTheme.bodyMedium!,
          color: Colors.black,
        ),
      ),
    ],
  );
}

PreferredSizeWidget todoDetailsAppBar(
    SelectedTodoState state, BuildContext context) {
  final screenSize = MediaQuery.of(context).size;

  return AppBar(
    backgroundColor: Colors.white,
    actions: [
      if (state.todoItem!.deadline != null) deadlineTooltip(state, context),
      if (state.todoItem!.deadline == null)
        Image.asset(
          'assets/icons/clock.png',
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      const SizedBox(width: 12),
      editButton(state, screenSize, context),
      const SizedBox(width: 12),
      deleteButton(state, context),
      const SizedBox(width: 12),
    ],
  );
}

Widget deadlineTooltip(SelectedTodoState state, BuildContext context) {
  return Tooltip(
    message: state.todoItem!.formattedDeadline,
    decoration: ShapeDecoration(
      shape: const CustomDetailsToolTipShape(),
      color: Theme.of(context).colorScheme.secondary,
    ),
    preferBelow: false,
    verticalOffset: -60,
    textAlign: TextAlign.justify,
    height: 5,
    child: GestureDetector(
      onTap: () {},
      child: Image.asset(
        'assets/icons/clock.png',
        color: Colors.black,
      ),
    ),
  );
}

Widget editButton(
    SelectedTodoState state, Size screenSize, BuildContext context) {
  return GestureDetector(
    onTap: () => showModalBottomSheet(
      useSafeArea: true,
      constraints: BoxConstraints(maxHeight: screenSize.height * 0.9),
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      context: context,
      builder: (innerContext) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: BlocProvider.of<TodoBloc>(context),
          ),
          BlocProvider.value(
            value: BlocProvider.of<SelectedTodoCubit>(context),
          ),
        ],
        child: EditTodo(
          item: state.todoItem!,
          itemIdx: state.index!,
        ),
      ),
    ),
    child: Image.asset(
      'assets/icons/edit.png',
      color: Colors.black,
    ),
  );
}

Widget deleteButton(SelectedTodoState state, BuildContext context) {
  return GestureDetector(
    onTap: () => showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return deleteConfirmationSheet(state, context);
      },
    ),
    child: Image.asset('assets/icons/trash.png', color: Colors.black),
  );
}

Widget deleteConfirmationSheet(SelectedTodoState state, BuildContext context) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16.0),
    decoration: const BoxDecoration(
      color: Colors.transparent,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LargeButton(
          textWidget: AppText(
            text: "Delete TODO",
            color: Theme.of(context).colorScheme.primary,
            style: customTextTheme.bodyLarge!,
          ),
          onPressed: () {
            context.read<TodoBloc>().add(
                  DeleteTodoEvent(state.todoItem!),
                );
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          backgroundColor: Colors.white,
        ),
        const SizedBox(height: 10),
        LargeButton(
          textWidget: AppText(
            text: "Cancel",
            color: const Color.fromARGB(155, 66, 225, 72),
            style: customTextTheme.bodyLarge!,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          backgroundColor: Colors.white,
        ),
      ],
    ),
  );
}

Widget todoImage(String imagePath) {
  return Image.file(
    File(imagePath),
    width: double.infinity,
    height: 300,
    fit: BoxFit.fitWidth,
  );
}
