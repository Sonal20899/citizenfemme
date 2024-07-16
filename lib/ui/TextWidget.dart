import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget Titletext(BuildContext context, String name) {
  return Text(
    name,
    style: GoogleFonts.notoSerif(
        fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
  );
}

Widget SubTitletext(BuildContext context, String name) {
  return Text(
    name,
    style: GoogleFonts.actor(fontSize: 19, color: Colors.black),
  );
}
