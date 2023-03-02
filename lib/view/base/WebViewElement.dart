import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/data/model/config_model.dart';

import '../../data/model/userAgent.dart';
import 'WebViewElementState.dart';

//import 'package:store_redirect/store_redirect.dart';

class WebViewElement extends StatefulWidget {
  String? initialUrl;
  String? loader;
  String? loaderColor;
  String? pullRefresh = "true";
  UserAgent? userAgent;
  String? customCss;
  String? customJavascript;
  List<String>? nativeApplication = [];
  ConfigModel settings;
  void Function()? onLoadEnd = ()=>{};

  WebViewElement(
      {Key? key,
      this.initialUrl,
      this.loader,
      this.loaderColor,
      this.pullRefresh,
      this.userAgent,
      this.customCss,
      this.customJavascript,
      this.nativeApplication,
      required this.settings,
      this.onLoadEnd})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => WebViewElementState();
}
