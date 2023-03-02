
import 'dart:ui';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {

    if(hexColor != null){
      hexColor = hexColor.toUpperCase().replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = "FF" + hexColor;
      }
      return int.parse(hexColor);
    }else {
      return int.parse("FFFFFF");
    }

  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}


