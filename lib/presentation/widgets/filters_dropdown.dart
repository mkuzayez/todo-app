import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/business_logic/todos_bloc/todo_items_bloc.dart';
import 'package:todo_app/presentation/custom_widgets/custom_text.dart';
import 'package:todo_app/theme/text.dart';

class FiltersDropdownButton extends StatefulWidget {
  const FiltersDropdownButton({super.key});

  @override
  State<FiltersDropdownButton> createState() => _FiltersDropdownButtonState();
}

String selectedOption = 'All Todos';

class _FiltersDropdownButtonState extends State<FiltersDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        List<AppText> options = [
          AppText(
              text: 'All Todos',
              style: customTextTheme.bodyMedium!,
              color: selectedOption == 'All Todos'
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.black),
          AppText(
              text: 'Deadline',
              style: customTextTheme.bodyMedium!,
              color: selectedOption == 'Deadline'
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.black),
          AppText(
            text: 'Sort',
            style: customTextTheme.bodyMedium!,
            color: selectedOption == 'Sort'
                ? Theme.of(context).colorScheme.secondary
                : Colors.black,
          )
        ];
        return DropdownButton<String>(
          underline: const SizedBox.shrink(),
          borderRadius: const BorderRadius.all(Radius.zero),
          padding: const EdgeInsets.all(0),
          icon: Icon(
            Icons.filter_alt_outlined,
            color: Theme.of(context).colorScheme.secondary,
          ),
          items: [
            for (var option in options)
              DropdownMenuItem(
                value: option.text,
                child: option,
              ),
          ],
          onChanged: (value) {
            if (value == 'All Todos') {
              context.read<TodoBloc>().add(LoadTodos());
              setState(() {
                selectedOption = 'All Todos';
              });
            } else if (value == 'Deadline') {
              context.read<TodoBloc>().add(FilterTodosWithDeadline());
              setState(() {
                selectedOption = 'Deadline';
              });
            } else if (value == 'Sort') {
              context.read<TodoBloc>().add(SortTodosByDate());

              setState(() {
                selectedOption = 'Sort';
              });
            }
          },
        );
      },
    );
  }
}
