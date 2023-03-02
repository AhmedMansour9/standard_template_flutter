import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/utill/routes.dart';
import 'package:webview_flutter/view/bottom_navigation/home.dart';
import 'package:webview_flutter/view/empty_page.dart';

import '../view/splash/splash_screen.dart';



class RouterHelper {
  static final FluroRouter router = FluroRouter();

//*******Handlers*********
  static Handler _splashHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => SplashScreen());
  // static Handler _mainhHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => HomeScreen());
  static final Handler _emptyPageHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => EmptyPage());


//*******Route Define*********
  static void setupRouter() {
    router.notFoundHandler = _emptyPageHandler;
    router.define(Routes.SPLASH_SCREEN, handler: _splashHandler, transitionType: TransitionType.fadeIn);
    // router.define(Routes.MAIN_SCREEN, handler: _mainhHandler, transitionType: TransitionType.fadeIn);

  }
}