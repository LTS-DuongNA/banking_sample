import 'dart:async';

import 'package:bank_application/utils/pref_util.dart';
import 'package:bank_application/viewmodels/home_viewmodel.dart';
import 'package:bank_application/views/admin/home_navigation.dart';
import 'package:bank_application/views/user/home_user.dart';
import 'package:bank_application/views/admin/home_view.dart';
import 'package:bank_application/views/common/signin_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'consts/colors/colors.dart';
import 'consts/strings/str_const.dart';
import 'generated/l10n.dart';
import 'localization/language_constants.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {

    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();

    await PrefUtil.init();

    if (PrefUtil.preferences.getBool(StrConst.isDarkMode) == null) {
      var brightness = SchedulerBinding.instance.window.platformBrightness;
      bool isDarkMode = brightness == Brightness.dark;
      PrefUtil.setValue(StrConst.isDarkMode, isDarkMode);
    }

    if (PrefUtil.getValue(StrConst.languageKey, 'vi') == 'vi') {
      await S.load(const Locale.fromSubtags(languageCode: 'vi')); // mimic localization delegate init
    } else {
      await S.load(const Locale.fromSubtags(languageCode: 'en')); // mimic localization delegate init
    }

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
      runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => HomeViewModel(),
          ),
        ],
        child: Builder(builder: (context) {
          return const MyApp();
        }),
      ));
    });
  }, (error, stackTrace) => print(error.toString() + stackTrace.toString()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale(StrConst.vietnamLanguageCode);

  setLocale(Locale locale) {
    if (PrefUtil.getValue(StrConst.languageKey, 'vi') == 'vi') {
      _locale = const Locale(StrConst.vietnamLanguageCode);
    } else {
      _locale = const Locale(StrConst.englishLanguageCode);
    }

    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<HomeViewModel>(context, listen: true);

    if (_locale == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return MaterialApp(
          theme: ThemeData(
            highlightColor: Colors.transparent,
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: ColorStyle.getDarkLabel(),
              selectionColor: ColorStyle.getDarkLabel(),
              selectionHandleColor: ColorStyle.getDarkLabel(),
            ),
          ),
          // theme: FlexThemeData.dark(scheme: FlexScheme.mandyRed),
          // // The Mandy red, dark theme.
          // darkTheme: FlexThemeData.light(scheme: FlexScheme.mandyRed),
          // // Use dark or light theme based on system setting.
          // themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          locale: _locale,
          supportedLocales: const [
            Locale(StrConst.englishLanguageCode, StrConst.englishCountryCode),
            Locale(StrConst.vietnamLanguageCode, StrConst.vietnamCountryCode),
          ],
          localizationsDelegates: const [
            // AppLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode &&
                  supportedLocale.countryCode == locale?.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          // home: HomeNavigator());
          home: HomeViewUser());
    }
  }
}
