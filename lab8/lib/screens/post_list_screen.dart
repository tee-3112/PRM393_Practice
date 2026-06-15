import 'package:flutter/material.dart';

import '../models/post.dart';
import '../services/api_service.dart';

class PostListScreen extends StatelessWidget {

  final ApiService apiService = ApiService();

  PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),

      body: FutureBuilder<List<Post>>(

        future: apiService.fetchPosts(),

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {

            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          }

          if (!snapshot.hasData) {

            return const Center(
              child: Text('No data'),
            );
          }

          List<Post> posts = snapshot.data!;

          return ListView.builder(

            itemCount: posts.length,

            itemBuilder: (context, index) {

              Post post = posts[index];

              return Card(
                margin: const EdgeInsets.all(8),

                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(post.id.toString()),
                  ),

                  title: Text(post.title),

                  subtitle: Text(
                    post.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}