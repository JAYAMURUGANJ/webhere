import 'package:flutter/material.dart';

import '../utils/constants/constants.dart';
import '../utils/constants/theme.dart';
import '../widgets/common/app_wrapper.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppWrapper(
      childBuilder: (deviceScreenType, isDarkTheme) {
        return Center(
          child: SizedBox(
            width: 600,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppDetails.aboutTitle,
                  textAlign: TextAlign.center,
                  style: AppTypography().bodyTextLarge.copyWith(
                        color: isDarkTheme
                            ? theme.colorScheme.onSurface
                            : theme.colorScheme.primary,
                      ),
                ),
                const SizedBox(height: 20),
                Text(
                  AppDetails.aboutDescription,
                  textAlign: TextAlign.center,
                  style: AppTypography().bodyTextMedium,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
