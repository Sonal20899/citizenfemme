import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget CustomButton(String name, BuildContext context, Function()? ontap) {
  var media = MediaQuery.sizeOf(context);
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 20, horizontal: media.width * 0.08),
    child: GestureDetector(
      onTap: ontap,
      child: Container(
        height: 40,
        decoration: const BoxDecoration(color: Colors.black),
        child: Center(
          child: Text(name,
              style: GoogleFonts.domine(
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                  color: Colors.white)),
        ),
      ),
    ),
  );
}
