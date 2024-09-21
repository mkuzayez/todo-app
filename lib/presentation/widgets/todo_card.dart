import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/app_router.dart';
import 'package:todo_app/business_logic/todo_item_cubit/todo_item_cubit.dart';
import 'package:todo_app/business_logic/todos_bloc/todo_items_bloc.dart';
import 'package:todo_app/data/models/todo_item/to_do.dart';
import 'package:todo_app/presentation/custom_widgets/custom_text.dart';
import 'package:todo_app/presentation/styling/tooltip_shape.dart';
import 'package:todo_app/theme/text.dart';

TodoItem? deletedItem;

class TodoCard extends StatelessWidget {
  final TodoItem item;
  final int index;
  final void Function(TodoItem) undoDelete;

  const TodoCard(this.undoDelete,
      {super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectedTodoCubit(),
      child: Builder(builder: (context) {
        return Slidable(
          key: Key(item.title),
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              Expanded(
                child: Card(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: TextButton(
                      onPressed: () {
                        deletedItem = item;
                        context.read<TodoBloc>().add(
                              DeleteTodoEvent(deletedItem!),
                            );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              'Item deleted.',
                            ),
                            action: SnackBarAction(
                              label: "Undo",
                              textColor: Colors.green,
                              onPressed: () {
                                undoDelete(deletedItem!);
                                
                              },
                            ),
                            duration: const Duration(seconds: 5),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          AppText(
                            text: "Delete",
                            style: customTextTheme.bodyLarge!,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              context.read<SelectedTodoCubit>().updateSelectedTodo(item, index);
              Navigator.of(context).pushNamed(
                '/details',
                arguments: TodoDetailsArguments(
                  provider: BlocProvider.of<SelectedTodoCubit>(context),
                ),
              );
            },
            child: SizedBox(
              height: 142,
              width: double.maxFinite,
              child: Card(
                color: item.deadline == null
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: AppText(
                              text: item.title,
                              style: customTextTheme.bodyLarge!,
                              overflow: TextOverflow.ellipsis,
                              maxLine: 1,
                            ),
                          ),
                          if (item.deadline != null)
                            Tooltip(
                              message: item.formattedDeadline,
                              decoration: ShapeDecoration(
                                shape: const CustomToolTipShape(),
                                color: Colors.grey[850],
                              ),
                              waitDuration: const Duration(seconds: 5),
                              preferBelow: false,
                              verticalOffset: -50,
                              textAlign: TextAlign.justify,
                              height: 1,
                              child: GestureDetector(
                                onTap: () {},
                                child: Image.asset(
                                  'assets/icons/clock.png',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 6),
                        child: AppText(
                            text: item.description,
                            style: customTextTheme.bodyMedium!),
                      ),
                      const Spacer(),
                      AppText(
                        text: 'Created at ${item.formattedDate}',
                        style: customTextTheme.bodySmall!,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
