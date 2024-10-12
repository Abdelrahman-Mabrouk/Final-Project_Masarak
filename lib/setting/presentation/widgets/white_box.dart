import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';
import 'change_language_button.dart';
import 'change_theme_button.dart';

class WhiteBox extends StatelessWidget {
  const WhiteBox({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(55),
          topRight: Radius.circular(55),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 19),
          CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              radius: size.height * 0.055,
              child: Image.asset(AppAssets.metroLogo)),
          const SizedBox(height: 23),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: EdgeInsets.symmetric(
                  vertical: size.width > 800 ? 16 : 8, horizontal: 25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              'تطبيق مسارك',
              style: AppTextStyles.bodyMedium(context),
            ),
          ),
          SizedBox(
            width: size.width,
            child: SvgPicture.asset(
              AppAssets.customLine,
              fit: BoxFit.fill,
            ),
          ),
          const CustomButtons(),
        ],
      ),
    );
  }
}

class CustomButtons extends StatelessWidget {
  const CustomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Language and Theme Buttons !
        ChangeLanguageButton(
          selectedItem: 'عربي', // Pre-select Arabic
          onChanged: (value) {
            // Handle language change here
            print('Selected Language: $value');
          },
        ),
        const SizedBox(height: 25),
        ChangeThemeButton(
          selectedItem: 'Light Mode', // Pre-select Light Mode
          onChanged: (value) {
            // Handle theme change here
            print('Selected Theme: $value');
          },
        ),
        const SizedBox(height: 25),
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                'قيمنا علي جوجل بلاي',
                style: AppTextStyles.bodyMedium(context),
              ),
            ),
            SvgPicture.asset(AppAssets.googlePlayIcon),
          ],
        ),
        const SizedBox(height: 25),
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                'شارك التطبيق مع اصحابك',
                style: AppTextStyles.bodyMedium(context),
              ),
            ),
            Positioned(left: -10, child: SvgPicture.asset(AppAssets.shareIcon)),
          ],
        ),
      ],
    );
  }
}
