import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webhere/utils/constants/constants.dart';

import '../utils/constants/assets.dart';
import '../utils/constants/theme.dart';
import '../utils/enums.dart';
import '../widgets/common/app_menu.dart';
import '../widgets/common/app_wrapper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Build content based on device screen type and theme
  Widget _buildContent(BuildContext context, DeviceScreenType deviceScreenType,
      bool isDarkTheme) {
    final theme = Theme.of(context);

    // Use switch expression to handle different device screen types
    return switch (deviceScreenType) {
      DeviceScreenType.mobile =>
        _buildMobileLayout(context, theme, isDarkTheme),
      DeviceScreenType.tablet =>
        _buildTabletLayout(context, theme, isDarkTheme),
      DeviceScreenType.desktop =>
        _buildDesktopLayout(context, theme, isDarkTheme),
    };
  }

  // Mobile layout
  Widget _buildMobileLayout(
      BuildContext context, ThemeData theme, bool isDarkTheme) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            _buildLogo(context, isDarkTheme),
            const SizedBox(height: 20),
            _buildTitleAndDescription(theme, TextAlign.center, isDarkTheme),
          ],
        ),
      ),
    );
  }

  // Tablet layout
  Widget _buildTabletLayout(
      BuildContext context, ThemeData theme, bool isDarkTheme) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _buildTitleAndDescription(
                      theme, TextAlign.left, isDarkTheme),
                ),
                const SizedBox(width: 40),
                Expanded(child: _buildLogo(context, isDarkTheme)),
              ],
            ),
            const SizedBox(height: 30),
            Align(
                alignment: Alignment.topLeft,
                child: _buildContactButton(context, theme, isDarkTheme)),
          ],
        ),
      ),
    );
  }

  // Desktop layout
  Widget _buildDesktopLayout(
      BuildContext context, ThemeData theme, bool isDarkTheme) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  _buildTitleAndDescription(theme, TextAlign.left, isDarkTheme),
                  const SizedBox(height: 30),
                  Align(
                      alignment: Alignment.topLeft,
                      child: _buildContactButton(context, theme, isDarkTheme)),
                ],
              ),
            ),
            const SizedBox(width: 60),
            Expanded(
              child: _buildLogo(context, isDarkTheme),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable logo widget with theme-aware styling
  Widget _buildLogo(BuildContext context, bool isDarkTheme) {
    return Center(
      child: TweenAnimationBuilder(
        duration: const Duration(seconds: 2),
        tween: Tween<double>(begin: 0, end: 1),
        builder: (context, opacity, child) {
          return Opacity(
            opacity: opacity,
            child: Image.asset(
              AppAsset.appLogo,
              width: 300,
              height: 300,
              fit: BoxFit.contain,
              color: isDarkTheme ? Colors.white70 : null,
              colorBlendMode: isDarkTheme ? BlendMode.modulate : null,
            ),
          );
        },
      ),
    );
  }

  // Reusable title and description widget with theme-aware styling
  Widget _buildTitleAndDescription(
      ThemeData theme, TextAlign textAlign, bool isDarkTheme) {
    return Column(
      crossAxisAlignment: textAlign == TextAlign.center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome to ${AppDetails.appName}',
          textAlign: textAlign,
          style: AppTypography().bodyTextLarge.copyWith(
                color: isDarkTheme
                    ? theme.colorScheme.onSurface
                    : theme.colorScheme.primary,
              ),
        ),
        const SizedBox(height: 20),
        Text(
          AppDetails.appDescription,
          textAlign: textAlign,
          style: AppTypography().bodyTextMedium,
        ),
      ],
    );
  }

  // Reusable contact button with theme-aware styling
  Widget _buildContactButton(
      BuildContext context, ThemeData theme, bool isDarkTheme) {
    return OutlinedButton(
      onPressed: () => context.go(navItems[4].route),
      child: Text(
        AppDetails.contactTitle,
        style: AppTypography().buttonTextMedium.copyWith(
              color: isDarkTheme
                  ? theme.colorScheme.onSecondary
                  : theme.colorScheme.primary,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppWrapper(
      childBuilder: (deviceScreenType, isDarkTheme) {
        return _buildContent(context, deviceScreenType, isDarkTheme);
      },
    );
  }
}
