import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context, Function setState) {
  setState(() {});
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(child: CircularProgressIndicator());
    },
  );
}

void hideLoadingDialog(BuildContext context, Function setState) {
  setState(() {});
  Navigator.of(context).pop();
}
