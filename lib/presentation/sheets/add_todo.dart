import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/business_logic/todos_bloc/todo_items_bloc.dart';
import 'package:todo_app/data/models/todo_item/to_do.dart';
import 'package:todo_app/theme/text.dart';
import 'package:todo_app/presentation/custom_widgets/content_field.dart';
import 'package:todo_app/presentation/widgets/deadline_field.dart';
import 'package:todo_app/presentation/custom_widgets/large_button.dart';
import 'package:todo_app/presentation/custom_widgets/custom_text.dart';
import 'package:todo_app/presentation/widgets/image_picker_field.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  DateTime? deadline;
  String? selectedImagePath;

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void getDeadlineDate(DateTime? date) {
    setState(() {
      deadline = date;
    });
  }

  void onImagePicked(String? imagePath) {
    setState(() {
      selectedImagePath = imagePath;
    });
  }

  @override
  void initState() {
    deadline = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            TodoTextField(
              controller: titleController,
              label: 'Title',
              style: customTextTheme.bodyMedium!,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TodoTextField(
                controller: contentController,
                label: 'Content',
                style: customTextTheme.bodyMedium!,
                expands: true,
                maxLine: null,
                minLine: 20,
                keyboardType: TextInputType.multiline,
              ),
            ),
            const SizedBox(height: 16),
            DeadlineField(
              onDatePicked: getDeadlineDate,
            ),
            const SizedBox(height: 16),
            ImagePickerField(
              onImagePicked: onImagePicked,
            ),
            const SizedBox(height: 16),
            LargeButton(
              textWidget: AppText(
                text: 'ADD TODO',
                style: customTextTheme.bodyLarge!,
                color: Theme.of(context).colorScheme.primary,
              ),
              backgroundColor: Colors.white,
              onPressed: () {
                if (titleController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: AppText(
                        text: 'Title cannot be empty',
                        style: customTextTheme.bodyMedium!,
                        color: Colors.black,
                      ),
                    ),
                  );
                  return;
                }
                final newTodo = TodoItem(
                  title: titleController.text,
                  description: contentController.text,
                  date: DateTime.now(),
                  deadline: deadline,
                  image: selectedImagePath,
                );

                context.read<TodoBloc>().add(AddTodoEvent(newTodo));
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
