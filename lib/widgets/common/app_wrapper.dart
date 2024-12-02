import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/theme/theme_cubit.dart';
import '../../utils/enums.dart';
import 'app_menu.dart';
import 'app_theme_changer.dart';

class AppWrapper extends StatelessWidget {
  final Widget Function(DeviceScreenType deviceScreenType, bool isDarkTheme)
      childBuilder;

  const AppWrapper({super.key, required this.childBuilder});

  // Use a method to determine device screen type
  DeviceScreenType _getDeviceScreenType(double screenWidth) =>
      switch (screenWidth) {
        >= 1024 => DeviceScreenType.desktop,
        >= 768 && < 1024 => DeviceScreenType.tablet,
        _ => DeviceScreenType.mobile,
      };

  @override
  Widget build(BuildContext context) {
    final (width, height) =
        (MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);

    final deviceScreenType = _getDeviceScreenType(width);

    return switch ((context.watch<ThemeCubit>().state, deviceScreenType)) {
      (final AppThemeState savedTheme, DeviceScreenType.desktop) =>
        _buildDesktopLayout(context, savedTheme, deviceScreenType),
      (final AppThemeState savedTheme, DeviceScreenType.tablet) =>
        _buildTabletLayout(context, savedTheme, deviceScreenType),
      (final AppThemeState savedTheme, DeviceScreenType.mobile) =>
        _buildMobileLayout(context, savedTheme, deviceScreenType),
    };
  }

  BlocBuilder<ThemeCubit, AppThemeState> _buildDesktopLayout(
      BuildContext context,
      AppThemeState savedTheme,
      DeviceScreenType deviceScreenType) {
    return BlocBuilder<ThemeCubit, AppThemeState>(
      builder: (context, themeState) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: AppNavigation(deviceScreenType: deviceScreenType),
            automaticallyImplyLeading: false,
            actions: [
              ThemeChanger(savedTheme: savedTheme),
            ],
          ),
          body:
              childBuilder(deviceScreenType, themeState == AppThemeState.dark),
        );
      },
    );
  }

  BlocBuilder<ThemeCubit, AppThemeState> _buildTabletLayout(
      BuildContext context,
      AppThemeState savedTheme,
      DeviceScreenType deviceScreenType) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocBuilder<ThemeCubit, AppThemeState>(
      builder: (context, themeState) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            elevation: 5,
            title: AppNavigation(deviceScreenType: deviceScreenType),
            automaticallyImplyLeading: false,
            actions: [
              ThemeChanger(savedTheme: savedTheme),
              IconButton(
                icon: const Icon(
                  Icons.menu,
                ),
                onPressed: () => scaffoldKey.currentState?.openDrawer(),
              )
            ],
          ),
          drawer: const AnimatedTabletNavBar(),
          body:
              childBuilder(deviceScreenType, themeState == AppThemeState.dark),
        );
      },
    );
  }

  BlocBuilder<ThemeCubit, AppThemeState> _buildMobileLayout(
      BuildContext context,
      AppThemeState savedTheme,
      DeviceScreenType deviceScreenType) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final router = GoRouter.of(context);
    final currentRoute =
        router.routerDelegate.currentConfiguration.uri.toString();

    return BlocBuilder<ThemeCubit, AppThemeState>(
      builder: (context, themeState) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            elevation: 5,
            title: AppNavigation(deviceScreenType: deviceScreenType),
            automaticallyImplyLeading: false,
            actions: [
              ThemeChanger(savedTheme: savedTheme),
            ],
          ),
          drawer: const AnimatedTabletNavBar(),
          bottomNavigationBar: MobileBottomNavBar(
            currentRoute: currentRoute,
          ),
          body:
              childBuilder(deviceScreenType, themeState == AppThemeState.dark),
        );
      },
    );
  }
}
