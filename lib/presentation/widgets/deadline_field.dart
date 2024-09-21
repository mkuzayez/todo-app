import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/presentation/custom_widgets/custom_text.dart';
import 'package:todo_app/theme/text.dart';

class DeadlineField extends StatefulWidget {
  const DeadlineField(
      {super.key, required this.onDatePicked, this.initialDate});

  final ValueChanged<DateTime?> onDatePicked;
  final DateTime? initialDate;

  @override
  State<DeadlineField> createState() => _DeadlineFieldState();
}

class _DeadlineFieldState extends State<DeadlineField> {
  DateTime? selectedDate;

  String formattedDate(DateTime? date) {
    return DateFormat('EE, dd MMMM yyyy').format(date!);
  }

  @override
  void initState() {
    if (widget.initialDate != null) {
      selectedDate = widget.initialDate;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color boxColor = selectedDate != null
        ? Colors.white
        : Theme.of(context).colorScheme.onPrimary;

    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2101),
        );

        if (pickedDate != DateTime.now()) {
          widget.onDatePicked(pickedDate);
          setState(() {
            selectedDate = pickedDate;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Container(
          height: 52,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: boxColor,
              width: 2,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: selectedDate != null
                    ? formattedDate(selectedDate)
                    : "Deadline (Optional)",
                style: customTextTheme.bodyLarge!,
                color: boxColor,
              ),
              Image.asset(
                'assets/icons/calendar.png',
                color: boxColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
