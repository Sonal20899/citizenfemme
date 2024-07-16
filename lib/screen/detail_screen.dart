import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart' as html;

import 'package:practice/API/api_list.dart';
import 'package:practice/screen/post_screen.dart';

import '../model/CategoriesModel.dart';
import '../model/detail_model.dart';

class DetailScreen extends StatefulWidget {
  final int id;
  const DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<DetailModel> getpostDetail;
  late Future<List<Categories>> getCategory;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getpostDetail = APIService().fetchPostById(widget.id);
    getCategory = APIService().fetchCategories();
  }

  String removeHtmlTags(String htmlString) {
    var document = html.parse(htmlString);
    return document.body?.text ?? '';
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
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
                ],
              ))),
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
      body: FutureBuilder<DetailModel>(
        future: getpostDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('No data found'),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text('No Category found'),
            );
          } else {
            final category = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Image.network(category.featuredImageUrl.toString(),
                      width: media.width * 0.95, fit: BoxFit.fill),
                  const SizedBox(height: 15),
                  const Divider(
                    thickness: 0.07,
                    color: Colors.black,
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                            category.featuredImageUrl.toString(),
                            width: media.width * 0.12,
                            height: media.height * 0.05,
                            fit: BoxFit.fill),
                      ),
                      const SizedBox(width: 10),
                      Text('By : ',
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400, fontSize: 12)),
                      Text(category.authorName.toString(),
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400, fontSize: 12)),
                      const SizedBox(width: 30),
                      Container(
                        width: 1,
                        height: media.height * 0.05,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 20),
                      Text(category.createdDate.toString(),
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400, fontSize: 12)),
                    ],
                  ),
                  const Divider(
                    thickness: 0.07,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      removeHtmlTags(category.content.toString()),
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400, fontSize: 11),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
