import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget MyTextField(
  BuildContext context,
  TextEditingController controller,
) {
  Size size = MediaQuery.sizeOf(context);
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: size.width * 0.08),
    child: Container(
      decoration: BoxDecoration(border: Border.all(width: 1)),
      child: TextField(
        style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 14),
        controller: controller,
        keyboardType: TextInputType.name,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        ),
      ),
    ),
  );
}
