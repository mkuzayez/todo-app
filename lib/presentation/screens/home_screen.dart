import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/business_logic/todos_bloc/todo_items_bloc.dart';
import 'package:todo_app/presentation/custom_widgets/custom_text.dart';
import 'package:todo_app/presentation/sheets/add_todo.dart';
import 'package:todo_app/presentation/widgets/filters_dropdown.dart';
import 'package:todo_app/presentation/widgets/todo_list.dart';
import 'package:todo_app/theme/text.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  final overlayPortalControllers = OverlayPortalController();
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<TodoBloc>().add(LoadTodos());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: InkWell(
        borderRadius: BorderRadius.circular(360),
        onTap: () => showModalBottomSheet(
          useSafeArea: true,
          constraints: BoxConstraints(maxHeight: screenSize.height * 0.9),
          showDragHandle: true,
          isScrollControlled: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
          context: context,
          builder: (innerContext) => BlocProvider.value(
            value: BlocProvider.of<TodoBloc>(context),
            child: const AddTodo(),
          ),
        ),
        child: Container(
          height: 68,
          width: 68,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(180),
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        titleSpacing: 24,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: GestureDetector(
              child: Image.asset('assets/icons/settings.png'),
              onTap: () {
                Navigator.of(context).pushNamed('/settings');
              },
            ),
          )
        ],
        title: AppText(
          text: 'TO DO LIST',
          style: customTextTheme.displaySmall!,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/icons/list.png'),
                const SizedBox(width: 10),
                AppText(
                  text: 'LIST OF TODO',
                  style: customTextTheme.displayMedium!,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const Spacer(),
                const FiltersDropdownButton(),
              ],
            ),
            SizedBox(height: screenSize.height * 0.025),
            const Expanded(child: TodoList())
          ],
        ),
      ),
    );
  }
}
