import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/CategoriesModel.dart';
import '../model/detail_model.dart';
import '../model/post_model.dart';

class APIService {
  String baseUrl = 'https://citizen-femme.com/wp-json/custom/v1';

  //Login Api
  Future<Map<String, dynamic>> userLogin({
    required String email,
    required String password,
  }) async {
    String url = '$baseUrl/login';
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "username": email,
          "password": password,
        }));
    if (response.statusCode == 200) {
      print('200 ${response.body}');
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      print('401 ${response.body}');
      return json.decode(response.body);
    } else {
      print('Ex ${response.body}');
      throw Exception("Failed");
    }
  }

  Future<List<Categories>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Categories.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<PostModel>> fetchPost(
    int? id,
  ) async {
    final response = await http.get(
      Uri.parse('$baseUrl/posts?category_id=$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => PostModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<DetailModel> fetchPostById(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/post/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      return DetailModel.fromJson(body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  //Contact us
  Future<Map<String, dynamic>> contactApi({
    required String email,
    required String username,
    required String subject,
    required String message,
  }) async {
    String url = 'https://citizen-femme.com/wp-json/gf/v2/forms/1/submissions';
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "input_1": username,
          "input_3": email,
          "input_4": subject,
          "input_5": message
        }));
    if (response.statusCode == 200) {
      print('200 ${response.body}');
      return json.decode(response.body);
    } else {
      print('Ex ${response.body}');
      throw Exception("Failed");
    }
  }
}
