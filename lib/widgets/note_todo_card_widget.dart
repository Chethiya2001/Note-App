import 'package:app/utils/colors.dart';
import 'package:app/utils/text_theme.dart';
import 'package:flutter/material.dart';

class NotesCardWidget extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  const NotesCardWidget(
      {super.key,
      required this.title,
      required this.description,
      required this.icon});

  @override
  State<NotesCardWidget> createState() => _NotesCardWidgetState();
}

class _NotesCardWidgetState extends State<NotesCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          children: [
            Icon(
              widget.icon,
              size: 30,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.title,
              style: AppTextStyles.appSubtitle,
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              widget.description,
              style: AppTextStyles.appDescriptionSmall.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
