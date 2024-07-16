import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../API/api_list.dart';
import '../ui/ButtonWidget.dart';
import '../ui/alert.dart';
import '../ui/loader.dart';
import '../ui/textfield_widget.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController msg = TextEditingController();

  //Contact Api
  String message = '';
  Future<void> contactUs() async {
    try {
      showLoadingDialog(context, setState);
      final response = await APIService().contactApi(
        email: email.text.trim(),
        username: username.text.trim(),
        subject: subject.text.trim(),
        message: msg.text.trim(),
      );
      if (response.containsKey('confirmation_message')) {
        message = response['confirmation_message'];
        showalertbox(context, message);
        hideLoadingDialog(context, setState);
        Navigator.pop(context);
      }
    } catch (e) {
      hideLoadingDialog(context, setState);
      showalertwarning(context, '$e');
      throw Exception('Fail $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        height: media.height * 1,
        width: media.width * 1,
        color: Colors.white,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: media.height * 0.07),
                    child: Text(
                      "Contact Us",
                      style: GoogleFonts.domine(
                          fontWeight: FontWeight.w400, fontSize: 24),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: media.width * 0.09, top: media.height * 0.02),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Text(
                            "Username",
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                          const SizedBox(width: 2),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Icon(
                              Icons.star_rate_sharp,
                              color: Colors.red,
                              size: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  MyTextField(context, username),
                  Padding(
                    padding: EdgeInsets.only(left: media.width * 0.09),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Text(
                            "Email Id",
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                          const SizedBox(width: 2),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Icon(
                              Icons.star_rate_sharp,
                              color: Colors.red,
                              size: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  MyTextField(context, email),
                  Padding(
                    padding: EdgeInsets.only(left: media.width * 0.09),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Text(
                            "Subject",
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                          const SizedBox(width: 2),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Icon(
                              Icons.star_rate_sharp,
                              color: Colors.red,
                              size: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  MyTextField(context, subject),
                  Padding(
                    padding: EdgeInsets.only(left: media.width * 0.09),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Message",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 5, horizontal: media.width * 0.08),
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: TextField(
                        maxLines: 5,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                        controller: msg,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                        ),
                      ),
                    ),
                  ),
                  CustomButton(
                    "Submit",
                    context,
                    () {
                      contactUs();
                      print('Hello');
                    },
                  )
                ],
              ),
            )),
      ),
    );
  }
}
