import 'package:cosmodex/logic/data/alien_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:cosmodex/common_libs.dart';

/// Shared paths / urls used across the app
class ScreenPaths {
  static String splash = '/';
  static String intro = '/welcome';
  static String home = '/home';
  static String settings = '/settings';
  static String alienDetails(AlienType type, {int tabIndex = 0}) =>
      '/alien/${type.name}?t=$tabIndex';
  static String search(AlienType type) => '/search/${type.name}';
}

/// Routing table, matches string paths to UI Screens
final appRouter = GoRouter(
  redirect: _handleRedirect,
  navigatorBuilder: (_, __, child) => WondersAppScaffold(child: child),
  routes: [
    AppRoute(
        ScreenPaths.splash,
        (_) =>
            Container(color: $styles.colors.greyStrong)), // This will be hidden
    AppRoute(ScreenPaths.home, (_) => HomeScreen()),
    AppRoute(ScreenPaths.intro, (_) => IntroScreen()),
    AppRoute('/wonder/:type', (s) {
      int tab = int.tryParse(s.queryParams['t'] ?? '') ?? 0;
      return WonderDetailsScreen(
        type: _parseAlienType(s.params['type']!),
        initialTabIndex: tab,
      );
    }, useFade: true),
    AppRoute('/search/:type', (s) {
      return ArtifactSearchScreen(type: _parseAlienType(s.params['type']!));
    }),
  ],
);

/// Custom GoRoute sub-class to make the router declaration easier to read
class AppRoute extends GoRoute {
  AppRoute(String path, Widget Function(GoRouterState s) builder,
      {List<GoRoute> routes = const [], this.useFade = false})
      : super(
          path: path,
          routes: routes,
          pageBuilder: (context, state) {
            final pageContent = Scaffold(
              body: builder(state),
              resizeToAvoidBottomInset: false,
            );
            if (useFade) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: pageContent,
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            }
            return CupertinoPage(child: pageContent);
          },
        );
  final bool useFade;
}

String? _handleRedirect(GoRouterState state) {
  // Prevent anyone from navigating away from `/` if app is starting up.
  if (!appLogic.isBootstrapComplete && state.location != ScreenPaths.splash) {
    return ScreenPaths.splash;
  }
  debugPrint('Navigate to: ${state.location}');
  return null; // do nothing
}

AlienType _parseAlienType(String value) =>
    _tryParseAlienType(value) ?? AlienType.zombie;

AlienType? _tryParseAlienType(String value) =>
    AlienType.values.asNameMap()[value];
