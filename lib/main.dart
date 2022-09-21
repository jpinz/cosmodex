import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:cosmodex/common_libs.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Keep native splash screen up until app is finished bootstrapping
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Start app
  registerSingletons();
  runApp(CosmodexApp());
  await appLogic.bootstrap();

  // Remove splash screen when bootstrap is complete
  FlutterNativeSplash.remove();
}

/// Creates an app using the [MaterialApp.router] constructor and the `appRouter`, an instance of [GoRouter].
class CosmodexApp extends StatelessWidget with GetItMixin {
  CosmodexApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: appRouter.routerDelegate,
      routeInformationProvider: appRouter.routeInformationProvider,
      routeInformationParser: appRouter.routeInformationParser,
      theme: ThemeData(fontFamily: $styles.text.body.fontFamily),
    );
  }
}

/// Create singletons (controllers and services) that can be shared across the app.
void registerSingletons() {
  // Top level app controller
  // GetIt.I.registerLazySingleton<AppLogic>(() => AppLogic());
  // Aliens
  // GetIt.I.registerLazySingleton<AliensLogic>(() => AliensLogic());
  // Search
  // GetIt.I.registerLazySingleton<MetAPILogic>(() => MetAPILogic());
  // GetIt.I.registerLazySingleton<MetAPIService>(() => MetAPIService());
  // Settings
  // GetIt.I.registerLazySingleton<SettingsLogic>(() => SettingsLogic());
}

/// Add syntax sugar for quickly accessing the main logical controllers in the app
/// We deliberately do not create shortcuts for services, to discourage their use directly in the view/widget layer.
// AppLogic get appLogic => GetIt.I.get<AppLogic>();
// AliensLogic get wondersLogic => GetIt.I.get<AliensLogic>();
// SettingsLogic get settingsLogic => GetIt.I.get<SettingsLogic>();
// MetAPILogic get metAPILogic => GetIt.I.get<MetAPILogic>();