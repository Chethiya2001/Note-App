import 'package:app/utils/colors.dart';
import 'package:app/utils/layout_consts.dart';
import 'package:app/utils/text_theme.dart';
import 'package:flutter/material.dart';

class ProgressCardWidget extends StatefulWidget {
  final int completedTask;
  final int totalTasks;

  const ProgressCardWidget(
      {super.key, required this.completedTask, required this.totalTasks});

  @override
  State<ProgressCardWidget> createState() => _ProgressCardWidgetState();
}

class _ProgressCardWidgetState extends State<ProgressCardWidget> {
  @override
  Widget build(BuildContext context) {
    //cal completed presentage
    double presentage = widget.totalTasks != 0
        ? (widget.completedTask / widget.totalTasks) * 100
        : 0;
    print(presentage);

    return Container(
      padding: const EdgeInsets.all(AppConstants.kDefaultPadding),
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Today's Progress",
                style: AppTextStyles.appSubtitle,
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Text(
                  "You Have Completes ${widget.completedTask} out of ${widget.totalTasks} Tasks,\nKeep it up!",
                  style: AppTextStyles.appDescriptionSmall.copyWith(
                    color: AppColors.kWhiteColor.withOpacity(0.5),
                  ),
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.width * 0.18,
                width: MediaQuery.of(context).size.width * 0.18,
                decoration: BoxDecoration(
                  gradient: AppColors().kPrimaryGradient,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Text(
                    "${presentage.toStringAsFixed(1)}%",
                    style: AppTextStyles.appSubtitle
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
