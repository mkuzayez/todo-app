import 'package:flutter/material.dart';
import 'package:todo_app/data/models/todo_item/to_do.dart';
import 'package:todo_app/data/models/user/user.dart';
import 'package:todo_app/theme/color_scheme.dart';
import 'package:todo_app/theme/text.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './app_router.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoItemAdapter());
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<List>('todoBox');
  await Hive.openBox<User>('authBox');
  await Hive.openBox('sessionBox');
  WidgetsFlutterBinding.ensureInitialized();

  print(Hive.box<List>('todoBox').keys);
  print(Hive.box<List>('todoBox').values);

  print(Hive.box<User>('authBox').keys);
  print(Hive.box<User>('authBox').values);

  print(Hive.box('sessionBox').keys);
  print(Hive.box('sessionBox').values);

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: customTextTheme,
        colorScheme: customColorTheme,
      ),
      onGenerateRoute: appRouter.generateRoute,
      initialRoute: '/',
    );
  }
}
