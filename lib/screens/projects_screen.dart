import 'package:flutter/material.dart';
import 'package:webhere/utils/constants/constants.dart';

import '../utils/constants/theme.dart';
import '../utils/enums.dart';
import '../widgets/common/app_wrapper.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

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
            crossAxisAlignment: isDesktop
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              Text(
                AppDetails.projectsTitle,
                textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                style: AppTypography().bodyTextLarge.copyWith(
                      color: isDarkTheme
                          ? theme.colorScheme.onSurface
                          : theme.colorScheme.primary,
                    ),
              ),
              SizedBox(height: isDesktop ? 20 : 10),
              Text(
                AppDetails.projectsDescription,
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
                        itemCount: AppDetails.projectItems.length,
                        itemBuilder: (context, index) {
                          final project = AppDetails.projectItems[index];
                          return _ProjectCard(
                            title: project['title']!,
                            description: project['description']!,
                          );
                        },
                      )
                    : ListView.builder(
                        itemCount: AppDetails.projectItems.length,
                        itemBuilder: (context, index) {
                          final project = AppDetails.projectItems[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: _ProjectCard(
                              title: project['title']!,
                              description: project['description']!,
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

class _ProjectCard extends StatelessWidget {
  final String title;
  final String description;

  const _ProjectCard({required this.title, required this.description});

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
