import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'to_do.g.dart';

@HiveType(typeId: 0)
class TodoItem extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final DateTime? deadline;

  @HiveField(4)
  final String? image;

  TodoItem({
    required this.title,
    required this.description,
    required this.date,
    this.deadline,
    this.image,
  });

  String get formattedDate {
    return DateFormat('d MMM yyyy').format(date);
  }

  String get formattedDeadline {
    return deadline != null ? DateFormat('dd/MM/yyyy').format(deadline!) : '';
  }
}
