import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class YourPathWidget extends StatelessWidget {
  const YourPathWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildPathText(context),
        _buildPathButton(context),

        // Button UI
      ],
    );
  }

  _buildPathText(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(AppAssets.orangeBackgroundShapes),
        Text.rich(TextSpan(children: [
          TextSpan(
              text: 'أعرف مسارك\n',
              style: AppTextStyles.bodyMedium(context)
                  .copyWith(color: AppColors.blackColor, fontSize: 20)),
          TextSpan(
              text: '        خطوة بخطوة',
              style: AppTextStyles.bodyMedium(context)
                  .copyWith(color: AppColors.NavBarColor, fontSize: 20)),
        ]))
      ],
    );
  }

  _buildPathButton(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          width: 120,
          height: 50,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(30)),
          child: Text('أقرب\nمحطة',
              style: AppTextStyles.bodySmall(context)
                  .copyWith(color: AppColors.NavBarColor)),
        ),
        Container(
          width: 80,
          height: 50,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: AppColors.NavBarColor,
              borderRadius: BorderRadius.circular(30)),
          child: SvgPicture.asset(AppAssets.directionsIcon),
        )
      ],
    );
  }
}
