import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice/screen/post_screen.dart';

import '../API/api_list.dart';
import '../model/CategoriesModel.dart';
import 'contact_screen.dart';

class SlideBar extends StatefulWidget {
  const SlideBar({super.key});

  @override
  State<SlideBar> createState() => _SlideBarState();
}

class _SlideBarState extends State<SlideBar> {
  late Future<List<Categories>> getCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategory = APIService().fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      drawer: Padding(
          padding: EdgeInsets.only(top: media.height * 0.07),
          child: Drawer(
              backgroundColor: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  ListTile(
                    leading: Image.asset('assets/title.png',
                        height: media.height * 0.04,
                        width: media.width * 0.42,
                        fit: BoxFit.fill),
                    trailing: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close, size: 22),
                    ),
                  ),
                  Divider(
                    thickness: 0.7,
                    color: Colors.grey.shade300,
                  ),
                  Expanded(
                    // height: media.height * 0.5,
                    // color: Colors.red,
                    child: FutureBuilder<List<Categories>>(
                      future: getCategory,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text('No data found'),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text('No Category found'),
                          );
                        } else {
                          final category = snapshot.data!;
                          return ListView.builder(
                            itemCount: category.length,
                            itemBuilder: (context, index) {
                              final data = category[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PostPage(
                                          id: data.id!.toInt(),
                                          name: data.name.toString(),
                                        ),
                                      ));
                                },
                                child: Card(
                                  color: Colors.white,
                                  child: ListTile(
                                    title: Text(
                                      data.name.toString(),
                                      style: GoogleFonts.domine(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                    trailing: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => PostPage(
                                                id: data.id!.toInt(),
                                                name: data.name.toString(),
                                              ),
                                            ));
                                      },
                                      child: const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 18),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactPage(),
                          ));
                    },
                    child: Card(
                      color: Colors.white,
                      child: ListTile(
                        title: Text(
                          'Contact Us',
                          style: GoogleFonts.domine(
                              fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ContactPage(),
                                ));
                          },
                          child: const Icon(Icons.arrow_forward_ios_rounded,
                              size: 18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ))),
    );
  }
}
