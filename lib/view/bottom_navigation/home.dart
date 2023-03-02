import 'dart:async';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:webview_flutter/data/model/config_model.dart';

import '../../data/model/setting.dart';
import '../../localization/AppLanguage.dart';
import '../base/FloatingButton.dart';
import '../base/HexColor.dart';
import '../base/TabNavigationMenu.dart';
import '../base/WebViewElement.dart';
import '../base/WebViewElementState.dart';

GlobalKey<WebViewElementState> key0 = GlobalKey();
GlobalKey<WebViewElementState> key1 = GlobalKey();
GlobalKey<WebViewElementState> key2 = GlobalKey();
GlobalKey<WebViewElementState> key3 = GlobalKey();
GlobalKey<WebViewElementState> key4 = GlobalKey();
GlobalKey<WebViewElementState> keyMain = GlobalKey();
GlobalKey<WebViewElementState> keyWebView = GlobalKey();
List<GlobalKey<WebViewElementState>> listKey = [key0, key1, key2, key3, key4];

StreamController<int> _controllerStream0 = StreamController<int>();
StreamController<int> _controllerStream1 = StreamController<int>();
StreamController<int> _controllerStream2 = StreamController<int>();
StreamController<int> _controllerStream3 = StreamController<int>();
StreamController<int> _controllerStream4 = StreamController<int>();
List<StreamController<int>> listStream = [
  _controllerStream0,
  _controllerStream1,
  _controllerStream2,
  _controllerStream3,
  _controllerStream4
];

class HomeScreen extends StatefulWidget {
  // final String url;
  final ConfigModel configModel;

  const HomeScreen( this.configModel);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController tabController;
  int _currentIndex = 0;
  static GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription _linkSubscription;
  bool goToWeb = true;
  var appLanguage;
  String url = "";

  @override
  void initState() {
    super.initState();
    tabController = TabController(
        initialIndex: 0,
        length: Setting.getValue(
            widget.configModel.setting!, "tab_navigation_enable") ==
            "true"
            ? widget.configModel.tab!.length
            : 1,
        vsync: this);
    tabController.addListener(_handleTabSelection);

    // _handleIncomingLinks();
  }

  @override
  void didChangeDependencies() {
    var appLanguage = Provider.of<AppLanguage>(context);
    // appLanguage.addListener(() {
    //   changeLanguageListener(appLanguage);
    // });

    super.didChangeDependencies();
  }

  // void changeLanguageListener(listener) {
  //   if (Setting.getValue(widget.configModel.setting!, "tab_navigation_enable") ==
  //       "true") {
  //     List.generate(widget.configModel.tab!.length, (index) {
  //       getKeyByIndex(index).currentState!.webViewController?.loadUrl(
  //           urlRequest: URLRequest(
  //               url: Uri.parse(
  //                   renderTabUrl(index, listener!.appLocal!.languageCode))));
  //     });
  //   }
  // }

  // void _handleIncomingLinks() {
  //   _linkSubscription = uriLinkStream.listen((Uri? uri) async {
  //     if (!mounted) return;
  //     print('got uri 1: $uri');
  //     /*setState(() {
  //         _latestUri = uri;
  //       });*/
  //     var link = uri.toString().replaceAll(
  //         '${GlobalConfiguration().getValue('deeplink')}://url/', '');
  //     /* _webViewController?.loadUrl(
  //           urlRequest: URLRequest(url: Uri.parse(link)));*/
  //
  //     if (Setting.getValue(widget.configModel.setting!, "tab_navigation_enable") ==
  //         "true") {
  //       if (goToWeb) {
  //         setState(() {
  //           goToWeb = false;
  //         });
  //         final result = await Navigator.push(
  //             context,
  //             PageTransition(
  //                 type: PageTransitionType.rightToLeft,
  //                 child: WebScreen(link, widget.configModel)));
  //         setState(() {
  //           goToWeb = true;
  //         });
  //       } else {
  //         key0.currentState!.webViewController
  //             ?.loadUrl(urlRequest: URLRequest(url: Uri.parse(link)));
  //       }
  //     }
  //   }, onError: (Object err) {
  //     if (!mounted) return;
  //     print('got err: $err');
  //     /*setState(() {
  //         _latestUri = null;
  //       });*/
  //   });
  // }

  _handleTabSelection() {
    setState(() {
      _currentIndex = tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var bottomPadding = mediaQueryData.padding.bottom;

    var appLanguage = Provider.of<AppLanguage>(context);
    var languageCode = appLanguage.appLocal.languageCode;

    // // final _oneSignalHelper = OneSignalHelper();
    // Future<void> _listenerOneSignal() async {
    //   if (Setting.getValue(widget.configModel.setting!, "tab_navigation_enable") ==
    //       "true") {
    //     if (goToWeb) {
    //       setState(() {
    //         goToWeb = false;
    //       });
    //       // final result = await Navigator.push(
    //       //     context,
    //       //     PageTransition(
    //       //         type: PageTransitionType.rightToLeft,
    //       //         child: WebScreen(_oneSignalHelper.url!, widget.configModel)));
    //
    //       setState(() {
    //         goToWeb = true;
    //       });
    //     }
    //   } else {
    //     key0.currentState?.webViewController?.loadUrl(
    //         urlRequest: URLRequest(url: Uri.parse(_oneSignalHelper.url!)));
    //   }
    // }
    //
    // _oneSignalHelper.addListener(_listenerOneSignal);

    return WillPopScope(
        onWillPop: () async {
          getCurrentKey().currentState!.goBack();
          return false;
        },
        child: Container(
            decoration: const BoxDecoration(color: Color(0xfff5f4f4)),
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: Scaffold(
              key: _scaffoldKey,
              // appBar: AppBarHomeItem(
              //     configModel: widget.configModel,
              //     currentIndex: _currentIndex,
              //     listKey: listKey,
              //     scaffoldKey: _scaffoldKey),
              // drawer: (widget.configModel.leftNavigationIcon!.value ==
              //     "icon_menu" ||
              //     widget.configModel.rightNavigationIcon!.value == "icon_menu")
              //     ? SideMenuElement(configModel: widget.configModel, key0: key0)
              //     : null,
              body: Stack(fit: StackFit.expand, children: [
                Column(children: [
                  if (Setting.getValue(
                      widget.configModel.setting!, "tab_position") ==
                      "top")
                    TabNavigationMenu(
                        settings: widget.configModel,
                        listStream: listStream,
                        tabController: tabController,
                        currentIndex: _currentIndex),

                  //Text(Setting.getValue(widget.configModel.setting!, "tab_position")),
                  Expanded(
                    child: Setting.getValue(widget.configModel.setting!,
                        "tab_navigation_enable") ==
                        "true"
                        ? TabBarView(
                      controller: tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(widget.configModel.tab!.length,
                              (index) {
                            return WebViewElement(
                                key: listKey[index],
                                initialUrl: renderTabUrl(index, languageCode),
                                loader: Setting.getValue(
                                    widget.configModel.setting!, "loader"),
                                loaderColor: Setting.getValue(
                                    widget.configModel.setting!, "loaderColor"),
                                pullRefresh: Setting.getValue(
                                    widget.configModel.setting!, "pull_refresh"),
                                userAgent: widget.configModel.userAgent,
                                customCss: Setting.getValue(
                                    widget.configModel.setting!, "customCss"),
                                customJavascript: Setting.getValue(
                                    widget.configModel.setting!,
                                    "customJavascript"),
                                nativeApplication:
                                widget.configModel.nativeApplication,
                                settings: widget.configModel);
                          }),
                    )
                        : TabBarView(
                      controller: tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(1, (index) {
                        return WebViewElement(
                            key: listKey[0],
                            initialUrl: renderLang("url", languageCode),
                            loader: Setting.getValue(
                                widget.configModel.setting!, "loader"),
                            loaderColor: Setting.getValue(
                                widget.configModel.setting!, "loaderColor"),
                            pullRefresh: Setting.getValue(
                                widget.configModel.setting!, "pull_refresh"),
                            userAgent: widget.configModel.userAgent,
                            customCss: Setting.getValue(
                                widget.configModel.setting!, "customCss"),
                            customJavascript: Setting.getValue(
                                widget.configModel.setting!,
                                "customJavascript"),
                            nativeApplication:
                            widget.configModel.nativeApplication,
                            settings: widget.configModel);
                      }),
                    ),
                  )
                ])
              ]),
              bottomNavigationBar:
              Setting.getValue(widget.configModel.setting!, "tab_position") ==
                  "bottom"
                  ? TabNavigationMenu(
                  settings: widget.configModel,
                  listStream: listStream,
                  tabController: tabController,
                  currentIndex: _currentIndex)
                  : null,
              // floatingActionButton:
              // FloatingButton(settings: widget.configModel, key0: key0),
            )));
  }

  String renderTabUrl(index, languageCode) {
    if (widget.configModel.tab![index] != null) {
      if (widget.configModel.tab![index].translation[languageCode] != null) {
        return widget.configModel.tab![index].translation[languageCode]!["url"]!;
      }
    }
    return "";
  }

  GlobalKey<WebViewElementState> getCurrentKey() {
    switch (_currentIndex) {
      case 0:
        {
          return key0;
        }
      case 1:
        {
          return key1;
        }

      case 2:
        {
          return key2;
        }
      case 3:
        {
          return key3;
        }
      case 4:
        {
          return key4;
        }
      default:
        {
          return key0;
        }
    }
  }

  GlobalKey<WebViewElementState> getKeyByIndex(index) {
    switch (index) {
      case 0:
        {
          return key0;
        }

      case 1:
        {
          return key1;
        }

      case 2:
        {
          return key2;
        }
      case 3:
        {
          return key3;
        }
      case 4:
        {
          return key4;
        }
      default:
        {
          return key0;
        }
    }
  }

  String renderLang(type, languageCode) {
    if (widget.configModel.translation[languageCode] != null) {
      if (widget.configModel.translation[languageCode] != null) {
        return widget.configModel.translation[languageCode]![type]!;
      }
    }
    return " ";
  }
}

/*
WebViewElement(
                initialUrl: Setting.getValue(widget.configModel.setting!, "url"),
                loader: Setting.getValue(widget.configModel.setting!, "loader"),
                loaderColor:
                    Setting.getValue(widget.configModel.setting!, "loaderColor"),
                pullRefresh:
                    Setting.getValue(widget.configModel.setting!, "pull_refresh"),
                userAgent: widget.configModel.userAgent,
                customCss:
                    Setting.getValue(widget.configModel.setting!, "customCss"),
                customJavascript: Setting.getValue(
                    widget.configModel.setting!, "customJavascript"),
                nativeApplication: widget.configModel.nativeApplication,
              ),
 */
