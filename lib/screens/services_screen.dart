import 'package:flutter/material.dart';
import 'package:webhere/widgets/common/app_wrapper.dart';

import '../utils/constants/constants.dart';
import '../utils/constants/theme.dart';
import '../utils/enums.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppWrapper(
      childBuilder: (deviceScreenType, isDarkTheme) {
        bool isDesktop = deviceScreenType == DeviceScreenType.desktop;
        bool isTablet = deviceScreenType == DeviceScreenType.tablet;
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 100 : (isTablet ? 40 : 20),
            vertical: isDesktop ? 50 : 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppDetails.servicesTitle,
                textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                style: AppTypography().bodyTextLarge.copyWith(
                      color: isDarkTheme
                          ? theme.colorScheme.onSurface
                          : theme.colorScheme.primary,
                    ),
              ),
              SizedBox(height: isDesktop ? 20 : 10),
              Text(
                AppDetails.servicesDescription,
                textAlign: TextAlign.left,
                style: AppTypography().bodyTextMedium,
              ),
              SizedBox(height: isDesktop ? 40 : 20),
              Flexible(
                child: isDesktop
                    ? GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: 4 / 3,
                        ),
                        itemCount: AppDetails.serviceItems.length,
                        itemBuilder: (context, index) {
                          final service = AppDetails.serviceItems[index];
                          return _ServiceCard(
                            title: service['title']!,
                            description: service['description']!,
                          );
                        },
                      )
                    : ListView.builder(
                        itemCount: AppDetails.serviceItems.length,
                        itemBuilder: (context, index) {
                          final service = AppDetails.serviceItems[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: _ServiceCard(
                              title: service['title']!,
                              description: service['description']!,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String title;
  final String description;

  const _ServiceCard({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme().getBoxDecoration(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTypography().bodyTextMedium.copyWith(
                  color: isDarkTheme
                      ? theme.colorScheme.onSurface
                      : theme.colorScheme.primary,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(description,
              textAlign: TextAlign.center,
              style: AppTypography().bodyTextSmall),
        ],
      ),
    );
  }
}
