import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget DrawerList(BuildContext context, String Name) {
  return Card(
    color: Colors.white,
    child: ListTile(
      title: Text(
        Name,
        style: GoogleFonts.robotoSlab(fontSize: 16, color: Colors.black),
      ),
      trailing: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 20,
            color: Colors.black,
          )),
    ),
  );
}
