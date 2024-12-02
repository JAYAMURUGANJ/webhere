import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webhere/utils/enums.dart';

Future<AppThemeState> getSavedTheme() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    // Default to dark theme if no preference is set
    bool isDarkMode = prefs.getBool('isDarkMode') ?? true;
    return isDarkMode ? AppThemeState.dark : AppThemeState.light;
  } catch (e) {
    // Fallback to dark theme in case of any error
    debugPrint('Error retrieving theme: $e');
    return AppThemeState.dark;
  }
}
