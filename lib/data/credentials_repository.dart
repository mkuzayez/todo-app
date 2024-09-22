import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/models/todo_item/to_do.dart';
import 'package:todo_app/data/models/user/user.dart';

class CredentialsRepository {
  late final Box<User> authBox;
  late final Box sessionBox;
  late final Box<List> todoBox;

  CredentialsRepository() {
    todoBox = Hive.box<List>('todoBox');
    authBox = Hive.box<User>('authBox');
    sessionBox = Hive.box('sessionBox');
  }

  User? getSessionUser() {
    return sessionBox.get('sessionUser');
  }

  Future<void> setSessionUser(User user) async {
    await sessionBox.put('sessionUser', user);
  }

  Future<void> deleteSessionUser() async {
    await sessionBox.delete('sessionUser');
  }

  Future<void> signUpUser(User user) async {
    await authBox.put(user.email, user);
    await todoBox.put(user.email, <TodoItem>[]);
  }

  Future<void> changePassword(User user, String newPassword) async {
    final updatedUser = User(
      name: user.name,
      email: user.email,
      password: newPassword, 
    );

    await authBox.put(user.email, updatedUser);
  }

  User? getUser(String email) {
    return authBox.get(email);
  }

  bool userExists(String email) {
    return authBox.containsKey(email);
  }
}
