import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/theme/theme_cubit.dart';
import '../../utils/constants/assets.dart';
import '../../utils/constants/theme.dart';
import '../../utils/enums.dart';
import 'app_title.dart';

typedef NavItemRecord = ({IconData icon, String text, String route});

class NavItem {
  final IconData icon;
  final String text;
  final String route;

  const NavItem({
    required this.icon,
    required this.text,
    required this.route,
  });

  NavItem.fromRecord(NavItemRecord record)
      : icon = record.icon,
        text = record.text,
        route = record.route;
}

final navItems = [
  NavItem.fromRecord((
    icon: Icons.home,
    text: 'Home',
    route: '/',
  )),
  NavItem.fromRecord((
    icon: Icons.person,
    text: 'About',
    route: '/about',
  )),
  NavItem.fromRecord((
    icon: Icons.design_services,
    text: 'Services',
    route: '/services',
  )),
  NavItem.fromRecord((
    icon: Icons.workspace_premium,
    text: 'Projects',
    route: '/projects',
  )),
  NavItem.fromRecord((
    icon: Icons.contact_mail,
    text: 'Contact',
    route: '/contact',
  )),
];

class MobileBottomNavBar extends StatelessWidget {
  final String currentRoute;

  const MobileBottomNavBar({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: navItems.indexWhere((item) => item.route == currentRoute),
      onTap: (index) {
        if (index >= 0 && index < navItems.length) {
          context.go(navItems[index].route);
        }
      },
      items: navItems
          .map(
            (item) => BottomNavigationBarItem(
              icon: Icon(item.icon),
              label: item.text,
            ),
          )
          .toList(),
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.onSurface,
      type: BottomNavigationBarType.fixed, // Use fixed to display all items
    );
  }
}

class AnimatedTabletNavBar extends StatelessWidget {
  const AnimatedTabletNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: Image.asset(
              AppAsset.postor,
              width: 50,
              fit: BoxFit.fitWidth,
            ),
          ),
          // Use spread operator with map
          ...navItems.map((item) => _TabletNavItem(item)),
        ],
      ),
    );
  }
}

class WebNavBar extends StatelessWidget {
  final String currentRoute; // Add this to track the current route
  final bool isDarkTheme;

  const WebNavBar(
      {super.key, required this.currentRoute, required this.isDarkTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            children: [
              SizedBox(height: 10),
              AppTitle(),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: navItems
                  .map((item) => _WebNavItem(item, currentRoute, isDarkTheme))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabletNavItem extends StatelessWidget {
  final NavItem item;

  const _TabletNavItem(this.item);

  @override
  Widget build(BuildContext context) {
    return switch (item) {
      NavItem(text: final text, icon: final icon, route: final route) =>
        ListTile(
          leading: Icon(icon),
          title: Text(
            text,
            style: AppTypography().appMenuStyle,
          ),
          onTap: () => context.go(route),
        ),
    };
  }
}

class _WebNavItem extends StatelessWidget {
  final NavItem item;
  final String currentRoute;
  final bool isDarkTheme;

  const _WebNavItem(this.item, this.currentRoute, this.isDarkTheme);

  @override
  Widget build(BuildContext context) {
    final isSelected = currentRoute == item.route;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: () => context.go(item.route),
        style: AppTheme().getAdaptiveButtonStyle(
          context,
          isSelected: isSelected,
          defaultTextStyle: AppTypography().appMenuStyle,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              item.icon,
              color: isSelected
                  ? (isDarkTheme
                      ? theme.colorScheme.primary
                      : theme.colorScheme.primaryContainer)
                  : AppTypography().appMenuStyle.color,
            ),
            const SizedBox(width: 10),
            Text(
              item.text,
              style: isSelected
                  ? AppTypography()
                      .appMenuStyle
                      .copyWith(fontWeight: FontWeight.bold)
                  : AppTypography().appMenuStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class AppNavigation extends StatelessWidget {
  final DeviceScreenType deviceScreenType;

  const AppNavigation({super.key, required this.deviceScreenType});

  Widget _getNavigationWidget(BuildContext context) {
    final router = GoRouter.of(context);
    final currentRoute =
        router.routerDelegate.currentConfiguration.uri.toString();
    final currentTheme = context.watch<ThemeCubit>().state;

    return switch (deviceScreenType) {
      DeviceScreenType.desktop => WebNavBar(
          currentRoute: currentRoute,
          isDarkTheme: currentTheme == AppThemeState.dark),
      // DeviceScreenType.mobile => MobileBottomNavBar(currentRoute: currentRoute),
      _ => const AppTitle(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return _getNavigationWidget(context);
  }
}
