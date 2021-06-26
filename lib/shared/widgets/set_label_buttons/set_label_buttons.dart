import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/themes/appcolors.dart';
import 'package:payflow/shared/widgets/divider_vertical/divider_vertical_widget.dart';
import 'package:payflow/shared/widgets/label_button/label_button_widget.dart';

class SetLabelButtons extends StatelessWidget {
  final String primaryLabel;
  final VoidCallback primaryOnPressed;
  final String secondaryLabel;
  final VoidCallback secondaryOnPressed;
  final bool enablePrimaryColor;
  final bool enableSecondaryColor;
  const SetLabelButtons({
    Key? key,
    required this.primaryLabel,
    required this.primaryOnPressed,
    required this.secondaryLabel,
    required this.secondaryOnPressed,
    this.enablePrimaryColor = false,
    this.enableSecondaryColor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 1,
          color: AppColors.stroke,
        ),
        Container(
          color: AppColors.background,
          height: 56,
          child: Row(
            children: [
              Expanded(child: LabelButton(label: primaryLabel, onPressed: primaryOnPressed, style: enablePrimaryColor ? AppTextStyles.buttonPrimary : null,)),
              DividerVerticalWidget(),
              Expanded(child: LabelButton(label: secondaryLabel, onPressed: secondaryOnPressed, style: enableSecondaryColor ? AppTextStyles.buttonPrimary : null,)),
            ],
          ),
        ),
      ],
    );
  }
}
