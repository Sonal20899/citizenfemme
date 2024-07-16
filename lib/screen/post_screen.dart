import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice/API/api_list.dart';

import '../model/post_model.dart';
import 'detail_screen.dart';

class PostPage extends StatefulWidget {
  final int id;
  final String name;
  const PostPage({super.key, required this.id, required this.name});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late Future<List<PostModel>> getPost;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPost = APIService().fetchPost(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(size: 20, color: Colors.black),
        title: Text(
          widget.name,
          style: GoogleFonts.domine(fontWeight: FontWeight.w400, fontSize: 24),
        ),
      ),
      body: FutureBuilder<List<PostModel>>(
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
              itemCount: category.length,
              itemBuilder: (context, index) {
                final data = category[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              id: data.id!.toInt(),
                            ),
                          ));
                    },
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
                              // width: media.width * 0.9,
                            )),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            data.shortContent.toString(),
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400, fontSize: 11),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
