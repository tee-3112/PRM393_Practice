import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class ApiService {

  Future<List<Post>> fetchPosts() async {

    final response = await http.get(
      Uri.parse(
        'https://jsonplaceholder.typicode.com/posts',
      ),
    );

    if (response.statusCode == 200) {

      List<dynamic> jsonData =
      json.decode(response.body);

      return jsonData
          .map((item) => Post.fromJson(item))
          .toList();

    } else {
      throw Exception('Failed to load posts');
    }
  }
}