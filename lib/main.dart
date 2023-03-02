import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:webview_flutter/helper/router_helper.dart';
import 'package:webview_flutter/localization/app_localization.dart';
import 'package:webview_flutter/provider/home_provider.dart';
import 'package:webview_flutter/provider/localization_provider.dart';

import 'package:webview_flutter/provider/language_provider.dart';
import 'package:webview_flutter/provider/splash_provider.dart';
import 'package:webview_flutter/provider/theme_manager.dart';
import 'package:webview_flutter/provider/theme_provider.dart';
import 'package:webview_flutter/theme/dark_theme.dart';
import 'package:webview_flutter/theme/light_theme.dart';
import 'package:webview_flutter/utill/app_constants.dart';
import 'package:webview_flutter/utill/routes.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:provider/provider.dart';dark
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dependency.dart' as di;
import 'localization/AppLanguage.dart';
import 'package:flutter_downloader/flutter_downloader.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await FlutterDownloader.initialize(debug: true);

  WidgetsFlutterBinding.ensureInitialized();
  await di.initalize();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SplashProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LanguageProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LocalizationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<AppLanguage>()),
      ChangeNotifierProvider(create: (context) => di.sl<ThemeNotifier>()),
      ChangeNotifierProvider(create: (context) => di.sl<HomeProvider>()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp();


  static final navigatorKey = new GlobalKey<NavigatorState>();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  void initState()   {
    super.initState();
    RouterHelper.setupRouter();
    Provider.of<SplashProvider>(context, listen: false).initSharedData();

  }


  @override
  Widget build(BuildContext context) {
    List<Locale> _locals = [];
    AppConstants.languages.forEach((language) {
      _locals.add(Locale(language.languageCode!, language.countryCode));
    });

    return Consumer<SplashProvider>(
      builder: (context, splashProvider, child){
        return MaterialApp(
          onGenerateRoute: RouterHelper.router.generator,
          title: AppConstants.APP_NAME,
          debugShowCheckedModeBanner: false,
          navigatorKey: MyApp.navigatorKey,
          theme: Provider.of<ThemeProvider>(context).darkTheme ? dark : light,
          locale: Provider.of<LocalizationProvider>(context).locale,
          localizationsDelegates: const [
            AppLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: _locals,
        );
      },

    );
  }
}
