import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class ErrorAlert {
  static Widget alert(BuildContext context, String message) {
    if (Platform.isAndroid) {
      var okAction = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(S.current.ok),
      );
      return AlertDialog(
        title: Text(S.current.error),
        content: Text(message),
        actions: [
          okAction,
        ],
      );
    } else {
      return CupertinoAlertDialog(
        title: Text(S.current.error),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(S.current.ok),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    }
  }
}

class NotificationAlert {
  static Widget alert(BuildContext context, String message) {
    if (Platform.isAndroid) {
      var okAction = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(S.current.ok),
      );
      return AlertDialog(
        title: Text(S.current.notification),
        content: Text(message),
        actions: [
          okAction,
        ],
      );
    } else {
      return CupertinoAlertDialog(
        title: Text(S.current.notification),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(S.current.ok),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    }
  }
}

class TwoButtonAlert {
  static Widget twoButtonAlert(BuildContext context, String twoButtonTitle, String twoButtonDescription,
      CupertinoDialogAction firstAction, CupertinoDialogAction secondAction) {
    return CupertinoAlertDialog(
      title: Text(twoButtonTitle),
      content: Text(twoButtonDescription),
      actions: [firstAction, secondAction],
    );
  }
}
