import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/theme/theme_cubit.dart';
import '../../utils/enums.dart';

class ThemeChanger extends StatelessWidget {
  final AppThemeState savedTheme;

  const ThemeChanger({
    super.key,
    required this.savedTheme,
  });

  (IconData, ValueKey) get _themeIcon => switch (savedTheme) {
        AppThemeState.light => (Icons.nights_stay, const ValueKey('darkIcon')),
        AppThemeState.dark => (Icons.wb_sunny, const ValueKey('lightIcon')),
      };

  @override
  Widget build(BuildContext context) {
    final (iconData, iconKey) = _themeIcon;

    return IconButton(
      onPressed: () => context.read<ThemeCubit>().toggleTheme(),
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
        child: Icon(
          iconData,
          key: iconKey,
        ),
      ),
    );
  }
}
