import 'package:hive/hive.dart';
import 'package:todo_app/data/models/todo_item/to_do.dart';

class TodoRepository {
  var todoBox = Hive.box<List>('todoBox');

  String getLastSessionEmail() {
    
    return Hive.box('sessionBox').get('sessionUser').email;
  }

  Future<List<TodoItem>> loadItems() async {
    final email = getLastSessionEmail();

    final List<dynamic>? dynamicList = todoBox.get(email);
    return dynamicList?.cast<TodoItem>() ?? <TodoItem>[];
  }

  Future<void> addItem(TodoItem item) async {
    final lastSessionEmail = getLastSessionEmail();

    List<TodoItem> items = todoBox.get(lastSessionEmail,
            defaultValue: <TodoItem>[])?.cast<TodoItem>() ??
        <TodoItem>[];

    items.add(item);
    await todoBox.put(lastSessionEmail, items);
  }

  Future<void> editItem(TodoItem newItem, int index) async {
    final lastSessionEmail = getLastSessionEmail();

    List<TodoItem> items = todoBox.get(lastSessionEmail,
            defaultValue: <TodoItem>[])?.cast<TodoItem>() ??
        <TodoItem>[];

    if (index >= 0 && index < items.length) {
      items[index] = newItem;
      await todoBox.put(lastSessionEmail, items);
    } else {
      throw Exception("Invalid index");
    }
  }

  Future<void> deleteItem(TodoItem item) async {
    final lastSessionEmail = getLastSessionEmail();

    List<TodoItem> items = todoBox.get(lastSessionEmail,
            defaultValue: <TodoItem>[])?.cast<TodoItem>() ??
        <TodoItem>[];

    items.remove(item);
    await todoBox.put(lastSessionEmail, items);
  }
}

