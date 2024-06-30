import 'package:app/utils/colors.dart';
import 'package:app/utils/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainScreenTodo extends StatelessWidget {
  final String title;
  final String time;
  final String date;
  final bool isDone;
  const MainScreenTodo(
      {super.key,
      required this.title,
      required this.time,
      required this.date,
      required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.appSubtitle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  DateFormat.Hm().format(
                    DateTime.parse(time),
                  ),
                  style: AppTextStyles.appDescriptionSmall
                      .copyWith(color: AppColors.kWhiteColor.withOpacity(0.5)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  DateFormat.yMMMd().format(
                    DateTime.parse(date),
                  ),
                  style: AppTextStyles.appDescriptionSmall
                      .copyWith(color: AppColors.kWhiteColor.withOpacity(0.5)),
                ),
              ],
            ),
          ),
          Icon(
            isDone ? Icons.done_all_outlined : Icons.done_outline_outlined,
            color: isDone ? Colors.greenAccent : Colors.grey,
          ),
        ],
      ),
    );
  }
}
