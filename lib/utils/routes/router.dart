import 'package:go_router/go_router.dart';
import 'package:webhere/screens/home_screen.dart';

import '../../screens/about_screen.dart';
import '../../screens/contact_screen.dart';
import '../../screens/projects_screen.dart';
import '../../screens/services_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => NoTransitionPage(
        child: HomeScreen(),
      ),
    ),
    GoRoute(
      path: '/about',
      pageBuilder: (context, state) => NoTransitionPage(
        child: const AboutScreen(),
      ),
    ),
    GoRoute(
      path: '/services',
      pageBuilder: (context, state) => NoTransitionPage(
        child: const ServicesScreen(),
      ),
    ),
    GoRoute(
      path: '/projects',
      pageBuilder: (context, state) => NoTransitionPage(
        child: const ProjectsScreen(),
      ),
    ),
    GoRoute(
      path: '/contact',
      pageBuilder: (context, state) => NoTransitionPage(
        child: const ContactScreen(),
      ),
    ),
  ],
);
