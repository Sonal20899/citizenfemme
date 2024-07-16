import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice/screen/post_screen.dart';

import '../API/api_list.dart';
import '../model/CategoriesModel.dart';
import '../model/drawerList.dart';
import '../model/post_model.dart';
import '../ui/TextWidget.dart';
import 'contact_screen.dart';
import 'detail_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Categories>> getCategory;
  late Future<List<PostModel>> getPost;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategory = APIService().fetchCategories();
    getPost = APIService().fetchPost(11);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(size: 20, color: Colors.black),
        title: Image.asset('assets/title.png',
            height: media.height * 0.04,
            width: media.width * 0.4,
            fit: BoxFit.fill),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, size: 22),
          ),
        ],
      ),
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
      body: Container(
        height: media.height * 1,
        width: media.width * 1,
        color: Colors.white,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PostPage(
                                            id: 11.toInt(),
                                            name: "Travel",
                                          )));
                            },
                            child: Card(
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 2),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.asset(
                                  "assets/travel.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Text("Travel",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400, fontSize: 16))
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PostPage(
                                            id: 23.toInt(),
                                            name: "Culture",
                                          )));
                            },
                            child: Card(
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 2),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.asset(
                                  "assets/culture.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Text("Culture",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400, fontSize: 16))
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PostPage(
                                            id: 156.toInt(),
                                            name: "Style",
                                          )));
                            },
                            child: Card(
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 2),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.asset(
                                  "assets/style.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Text("Style",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400, fontSize: 16))
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PostPage(
                                            id: 158.toInt(),
                                            name: "Beauty",
                                          )));
                            },
                            child: Card(
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 2),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.asset(
                                  "assets/beauty.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Text("Beauty",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400, fontSize: 16))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text("Latest Podcast",
                  style: GoogleFonts.domine(
                      fontWeight: FontWeight.w400, fontSize: 24)),
            ),
            Container(
              height: media.height * 0.25,
              width: media.width * 1,
              //color: Colors.red,
              child: FutureBuilder<List<PostModel>>(
                future: getPost,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('No data found'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No Category found'),
                    );
                  } else {
                    final category = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: category.length,
                      itemBuilder: (context, index) {
                        final data = category[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Column(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                            id: data.id!.toInt(),
                                          ),
                                        ));
                                  },
                                  child: Image.network(
                                    data.featuredImage.toString(),
                                    width: media.width * 0.4,
                                    height: media.height * 0.15,
                                    fit: BoxFit.cover,
                                  )),
                              Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: media.width * 0.4,
                                  height: media.height * 0.08,
                                  child: Text(
                                    data.shortContent.toString(),
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostPage(
                                id: 158.toInt(),
                                name: "Beauty",
                              )));
                },

                // color: Colors.lime,
                child: Image.asset(
                  height: media.height * 0.15,
                  width: media.width * 0.9,
                  "assets/home_beauty.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
