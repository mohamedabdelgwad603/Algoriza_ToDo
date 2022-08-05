import 'package:flutter/material.dart';
import 'package:todo/core/utils/extentions.dart';
import 'package:todo/presentation/board/screens/board_layout_screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/assets_manger.dart';

class DefaultSplashScreen extends StatelessWidget {
  const DefaultSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreenView(
        // c: AppColors.primary,
        imageSrc: ImgAssets.todo,
        imageSize: 300,
        text: 'ToDo && Tasks && Reminders',
        duration: 6000,
        textType: TextType.TyperAnimatedText,
        textStyle: context.subtitle1?.copyWith(color: context.primaryColor),
        navigateRoute: BoardLayoutScreen(),
      ),
    );
  }
}
