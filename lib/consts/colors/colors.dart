import 'package:flutter/material.dart';

import '../../utils/pref_util.dart';
import '../strings/str_const.dart';

class ColorStyle {
  static const primary = Color(0xfff68c1f);
  static const secondary = Color(0xffED1F7D);
  static const secondary25 = Color(0x40ED1F7D);
  static const secondary80 = Color(0xcced1f7d);
  static const tertiary = Color(0xfff3cf1b);

  static const nBgColor = Color.fromRGBO(184, 201, 255, 1);
  static const nMainColor = Color.fromRGBO(28, 119, 225, 1);
  static const nGray = Color.fromRGBO(231, 236, 243, 1);
  static const nFocusInput = Color.fromRGBO(184, 201, 255, 1);
  static const nTextblack = Color.fromRGBO(9, 39, 86, 1);
  static const nTextblue = Color.fromRGBO(28, 119, 225, 1);
  static const nTextGray = Color.fromRGBO(  91, 102, 122, 1);
  static const ngrayc = Color.fromRGBO(  113, 126, 149, 1);
  static const grey500 = Color(0xff94A0B4);
  static const grey500bg = Color(0xffF7F9FC);
  static const nsha = Color.fromRGBO(  247, 249, 252, 1);

  static const nred = Color.fromRGBO(  255, 239, 239, 1);
  static const red = Color.fromRGBO(  245, 59, 104, 1);
  static const norange = Color.fromRGBO(   244, 147, 255, 1.0);

  static const nDarkorange= Color.fromRGBO(     255, 115, 14, 1);

  static const Color black = const Color(0xff000000);

  static const Color white = const Color(0xffffffff);
  static const Color whiteText = const Color(0xffFBFCFD);

  static const Color purple = const Color(0xff092756);
  static const Color line68 = const Color.fromARGB(255, 28, 180, 104);
  static const Color purple2 = const Color(0xff002866);
  static const Color purple3 = const Color(0xff1C77E1);

  static const Color grey = const Color(0xff717E95);
  static const Color grey2 = const Color(0xffd6dce0);

  static const Color grey3 = const Color(0x33d6dce0);
  static const Color grey4 = const Color(0x33ababab);

  static const Color pinkBg = const Color(0xffFAD3D4);


  static Color getSecondaryBackground() {
    if (PrefUtil.getValue(StrConst.isDarkMode, false) as bool == false) {
      return const Color(0xfff8f8f8);
    } else {
      return const Color(0xff1a1a1a);
    }
  }

  static Color getSystemBackground() {
    if (PrefUtil.getValue(StrConst.isDarkMode, false) as bool == false) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  static Color getDarkLabel() {
    if (PrefUtil.getValue(StrConst.isDarkMode, false) as bool == false) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  static Color getLightLabel() {
    if (PrefUtil.getValue(StrConst.isDarkMode, false) as bool == false) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }
}
