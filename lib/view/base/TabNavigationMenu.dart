import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/data/model/config_model.dart';

import '../../data/model/setting.dart';
import '../../localization/AppLanguage.dart';
import '../../provider/theme_manager.dart';
import 'HexColor.dart';

class TabNavigationMenu extends StatefulWidget {
  ConfigModel settings;
  List<StreamController<int>> listStream;
  TabController tabController;
  int currentIndex;

  TabNavigationMenu({
    Key? key,
    required this.settings,
    required this.listStream,
    required this.tabController,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TabNavigationMenu();
  }
}

class _TabNavigationMenu extends State<TabNavigationMenu> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeNotifier>(context);
    // bool isLight = themeProvider.isLightTheme;
    // Color tab_color_icon_active = renderColor(
    //     isLight ? "tab_color_icon_active" : "tab_color_icon_active_dark");
    // Color tab_color_icon_inactive = renderColor(
    //     isLight ? "tab_color_icon_inactive" : "tab_color_icon_inactive_dark");
    // Color tab_color_background = renderColor(
    //     isLight ? "tab_color_background" : "tab_color_background_dark");
    Color tab_color_icon_active = Color(0xFFFFFFFF);
    Color tab_color_icon_inactive = Color(0xFFFFFFFF);
    Color tab_color_background = Color(0xFFFFFFFF);
    return Setting.getValue(
                widget.settings.setting!, "tab_navigation_enable") ==
            "true"
        ? Material(
            color: tab_color_background,
            child: Container(
                decoration: BoxDecoration(
                  color: tab_color_background,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                height: 60.0,
                child: TabBar(
                    onTap: (index) {
                      for (int i = 0; i < widget.listStream.length; i++) {
                        widget.listStream[i].add(index);
                      }
                    },
                    indicator: UnderlineTabIndicator(
                      borderSide:
                          BorderSide(color: tab_color_icon_active, width: 2.5),
                      //insets: EdgeInsets.symmetric(horizontal:16.0)
                    ),
                    controller: widget.tabController,
                    labelColor: tab_color_icon_active,
                    unselectedLabelColor: tab_color_icon_inactive,
                    tabs: List.generate(widget.settings.tab!.length, (index) {
                      return Tab(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.network(
                                  widget.settings.tab![index].icon_url!,
                                  width: 25,
                                  height: 25,
                                  color: widget.currentIndex == index
                                      ? tab_color_icon_active
                                      : tab_color_icon_inactive),
                              SizedBox(height: 5),
                              Flexible(
                                  child: Text(
                                renderTabTitle(index),
                                //widget.settings.tab![index].title!,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.getFont(
                                  Setting.getValue(
                                      widget.settings.setting!, "google_font"),
                                  textStyle: TextStyle(
                                      fontSize: widget.settings.tab!.length == 5
                                          ? 8
                                          : 10,
                                      color: widget.currentIndex == index
                                          ? tab_color_icon_active
                                          : tab_color_icon_inactive),
                                ),
                                /* style: TextStyle(
                                          fontSize:
                                              widget.settings.tab!.length == 5
                                                  ? 8
                                                  : 10,
                                          color: widget.currentIndex == index
                                              ? tab_color_icon_active
                                              : tab_color_icon_inactive)*/
                              )),
                            ]),
                      );
                    }))))
        : Container(height: 0);
  }

  Color renderColor(color) {
    return HexColor(Setting.getValue(widget.settings.setting!, color));
  }

  String renderTabTitle(index) {
    var appLanguage = Provider.of<AppLanguage>(context);
    var languageCode = appLanguage.appLocal.languageCode;
    if (widget.settings.tab![index] != null) {
      if (widget.settings.tab![index].translation[languageCode] != null)
        return widget.settings.tab![index].translation[languageCode]!["title"]!;
    }
    return " ";
  }
}
