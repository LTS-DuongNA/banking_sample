import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../generated/l10n.dart';
import 'alert.dart';

class ExitAppScope extends StatelessWidget {
  final Widget child;

  const ExitAppScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          (await showDialog<bool>(
            context: context,
            builder: (c) => _alert(c),
          )) ??
          false,
      child: child,
    );
  }

  Widget _alert(BuildContext context) {
    return TwoButtonAlert.twoButtonAlert(
      context,
      S.current.warning,
      S.current.exit_app_message,
      CupertinoDialogAction(
        isDefaultAction: false,
        child: Text(S.current.yes),
        onPressed: () => SystemNavigator.pop(animated: true),
        // This prevent Back to quit!!
        // onPressed: () => Navigator.of(context).popUntil((route) {
        //   return (route.settings.name == URLConsts.splash || route.isFirst);
        // })
      ),
      CupertinoDialogAction(
        isDefaultAction: true,
        child: Text(S.current.no),
        onPressed: () => Navigator.of(context).pop(false),
      ),
    );
  }
}
