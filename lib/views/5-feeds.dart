import 'package:flutter/material.dart';
import 'package:wathaequi/view_models/feed_vm.dart';
import 'package:wathaequi/views/5a-createPost.dart';
import 'package:wathaequi/views/res/colors.dart';
import 'package:wathaequi/views/util/documentCard.dart';
import 'package:wathaequi/views/util/postView.dart';

import '../models/Post.dart';

class Feeds extends StatefulWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  final FeedViewModel _model = FeedViewModel();
  List<Post> posts = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreatePost(),
              ),
            );
            if (result != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("$result"),
                  duration: Duration(seconds: 3),
                ),
              );
            }
          },
          backgroundColor: mainColor,
          child: Icon(Icons.add),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
              child: Text(
                "My City Reports",
                style: TextStyle(
                    color: darkColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 35),
              ),
            ),
            StreamBuilder<List<Post>>(
                stream: _model.getPosts(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(color: darkColor, fontSize: 20),
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text('Loading...',
                          style: TextStyle(color: darkColor, fontSize: 20)),
                    );
                  }
                  posts = snapshot.data!;
                  if (posts.isNotEmpty) {


                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return PostView(post: posts[index]);
                        },
                        itemCount: posts.length,
                      ),
                    );
                  } else {
                    return Center(
                      child: Text('create signalements',
                          style: TextStyle(color: darkColor, fontSize: 20)),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
