import 'package:flutter/cupertino.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

void showalertbox(BuildContext context, String name) {
  QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: name,
      autoCloseDuration: Duration(seconds: 3),
      showConfirmBtn: false);
}

void showalertwarning(BuildContext context, String name) {
  QuickAlert.show(
      context: context,
      type: QuickAlertType.warning,
      text: name,
      autoCloseDuration: Duration(seconds: 3),
      showConfirmBtn: false);
}
