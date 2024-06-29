import 'package:app/utils/colors.dart';
import 'package:app/utils/layout_consts.dart';
import 'package:app/utils/text_theme.dart';
import 'package:flutter/material.dart';

class CategoryInputBottomSheet extends StatefulWidget {
  final Function() onNewNote;
  final Function() onNewCatergory;
  const CategoryInputBottomSheet(
      {super.key, required this.onNewNote, required this.onNewCatergory});

  @override
  State<CategoryInputBottomSheet> createState() =>
      _CategoryInputBottomSheetState();
}

class _CategoryInputBottomSheetState extends State<CategoryInputBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.kDefaultPadding * 1.5),
        child: Column(
          children: [
            GestureDetector(
              onTap: widget.onNewNote,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Create A New Note.",
                    style: AppTextStyles.appDescription,
                  ),
                  Icon(Icons.arrow_right_outlined)
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Divider(
              color: AppColors.kWhiteColor.withOpacity(0.3),
              thickness: 1,
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: widget.onNewCatergory,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Create A New Catergory.",
                      style: AppTextStyles.appDescription),
                  Icon(Icons.arrow_right_outlined)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
