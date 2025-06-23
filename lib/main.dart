import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vesti_art/core/models/creation.dart';
import 'package:vesti_art/core/models/creation_draft.dart';
import 'package:vesti_art/networking/api_creation.dart';
import 'package:vesti_art/ui/creation/details/prompting_details_page.dart';
import 'package:vesti_art/ui/creation/list/creation_list_page.dart';
import 'package:vesti_art/ui/generation/details/prompting_details_page.dart';
import 'package:vesti_art/ui/generation/loading/loading_page.dart';
import 'core/routing/app_routes.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'core/services/authentication_service.dart';
import 'ui/auth/login/login_page.dart';
import 'ui/auth/register/register_page.dart';
import 'package:vesti_art/ui/admin/admin_panel.View.dart';
import 'ui/common/theme/app_theme.dart';
import 'ui/generation/prompting/prompting_page.dart';
import 'ui/mobile/home/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthenticationService.instance.initialize();

  if (kIsWeb) {
    setUrlStrategy(PathUrlStrategy());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationService.instance),
      ],
      child: Consumer<AuthenticationService>(
        builder: (ctx, authService, _) {
          return MaterialApp(
            title: 'VestiArt',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.system,
            initialRoute: AppRoutes.home,
            onGenerateRoute: generateRoute,
          );
        },
      ),
    );
  }
}

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.home:
      return MaterialPageRoute(
        builder:
            (context) => kIsWeb ? const AdminPanelView() : const HomePage(),
      );

    case AppRoutes.login:
      return MaterialPageRoute(builder: (context) => const LoginPage());

    case AppRoutes.register:
      return MaterialPageRoute(builder: (context) => const RegisterPage());

    case AppRoutes.creationDetails:
      final arguments = settings.arguments as Creation?;
      return MaterialPageRoute(
        builder: (context) => CreationDetailsPage(creation: arguments),
      );

    case AppRoutes.creationList:
      final arguments = settings.arguments as Sort;
      return MaterialPageRoute(
        builder: (context) => CreationListPage(sort: arguments),
      );

    case AppRoutes.prompting:
      return MaterialPageRoute(builder: (context) => const PromptingPage());

    case AppRoutes.promptingLoading:
      final arguments = settings.arguments as List<CreationDraft>?;
      return MaterialPageRoute(
        builder: (context) => LoadingPage(creations: arguments ?? []),
      );

    case AppRoutes.promptingDetails:
      final arguments = settings.arguments as List<Creation>?;
      return MaterialPageRoute(
        builder: (context) => PromptingDetailsPage(creations: arguments ?? []),
      );

    default:
      return null;
  }
}
