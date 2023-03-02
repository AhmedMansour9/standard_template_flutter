import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/localization/language_constrants.dart';
import 'package:webview_flutter/provider/localization_provider.dart';
import 'package:webview_flutter/provider/splash_provider.dart';
import 'package:webview_flutter/utill/app_constants.dart';
import 'package:webview_flutter/utill/color_resources.dart';
import 'package:webview_flutter/utill/images.dart';
import 'package:webview_flutter/utill/routes.dart';
import 'package:webview_flutter/utill/styles.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../base/custom_snackbar.dart';
import '../bottom_navigation/home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();

    bool _firstTime = true;
    _onConnectivityChanged = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!_firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi &&
            result != ConnectivityResult.mobile;
        isNotConnected
            ? SizedBox()
            : _globalKey.currentState?.hideCurrentSnackBar();
        showCustomSnackBar(
            isNotConnected
                ? getTranslated('no_connection', context)
                : getTranslated('connected', context),
            context);
        if (!isNotConnected) {
          // _route();
        }
      }
      _firstTime = false;
    });

    Provider.of<SplashProvider>(context, listen: false).initSharedData();
    Provider.of<SplashProvider>(context, listen: false)
        .initConfig()
        .then((value) {
      if (value == true) {
        _route();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _onConnectivityChanged.cancel();
  }

  void _route() {
    Timer(const Duration(seconds: 3), () async {
      // Navigator.pushNamedAndRemoveUntil(
      //     context, Routes.getMainRoute(), (route) => false);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>
              HomeScreen(Provider.of<SplashProvider>(context, listen: false).configModel!)));
    
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.COLOR_DARKPRIMARY,
      body: ScaffoldMessenger(
        key: _globalKey,
        child: Center(
          child: Consumer<SplashProvider>(builder: (context, splash, child) {
            return Padding(
              padding: EdgeInsets.all(5),
              child: Center(
                child: Image.asset(
                  Images.logo,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
