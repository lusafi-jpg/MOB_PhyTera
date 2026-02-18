import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_home_screen.dart';
import '../../features/map/presentation/screens/map_screen.dart';
import '../../features/alerts/presentation/screens/alerts_screen.dart';
import '../../features/analytics/presentation/screens/analytics_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/devices/presentation/screens/devices_screen.dart';
import '../../features/dashboard/presentation/widgets/scaffold_with_navbar.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        // Tab 1: Dashboard
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => const DashboardHomeScreen(),
            ),
          ],
        ),
        // Tab 2: Map
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/map',
              builder: (context, state) => const MapScreen(),
            ),
          ],
        ),
        // Tab 3: Alerts
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/alerts',
              builder: (context, state) => const AlertsScreen(),
            ),
          ],
        ),
        // Tab 4: Analytics
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/analytics',
              builder: (context, state) => const AnalyticsScreen(),
            ),
          ],
        ),
        // Tab 5: Profile
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/devices',
      builder: (context, state) => const DevicesScreen(),
    ),
  ],
);
