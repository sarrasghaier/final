import 'package:flutter/material.dart';
import 'package:forum_republique/splash/splash.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  runApp(LoginUiApp());
}


class LoginUiApp extends StatelessWidget {

  final Color _primaryColor = HexColor('#b51248');
  final Color _accentColor = HexColor('#fc031c');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: _primaryColor,
        scaffoldBackgroundColor: Colors.grey.shade100,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(defaultPadding * 0.75),
            shape: const StadiumBorder(),
          ),
        ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red).copyWith(secondary: _accentColor),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const SplashScreen(),
    );
  }
}
