import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:wathaequi/views/res/colors.dart';

import '../../models/Post.dart';

class PostView extends StatelessWidget {
  final Post post;

  const PostView({super.key, required this.post});


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.black.withOpacity(0.25),
      borderOnForeground: true,
      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: mainColor,
                      child: Icon(Icons.person,color: Colors.white,),
                    ),
                    SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              post.fullNameCitizen!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 4,),
                            Text(
                              post.datePublication!.substring(0,10),
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2,),

                        Text(
                          post.wilaya!+", "+post.commune!,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: mainColor,
                          ),
                        ),
                      ],
                    ),


                  ],
                ),
                PopupMenuButton(
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                    PopupMenuItem(
                      value: 'update',
                      child: Text('Update'),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'delete') {
                      // delete the item
                    } else if (value == 'update') {
                      // update the item
                    }
                  },
                ),

              ],
            ),
            SizedBox(height: 16.0),
            Text(
              post.content!,
              style: TextStyle(),
            ),
            SizedBox(height: 10.0),

            Image.memory(
              Uint8List.fromList(base64.decode(post.picture!)),
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8,),
            Text(
              'Replies',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            post.reponces!.isNotEmpty?
            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                  margin: EdgeInsets.only(top: 4),
                  child: Text(post.reponces![index].content!,style: TextStyle(color: Colors.white),),
                  decoration: BoxDecoration(

                      color: mainColor,
                      borderRadius: BorderRadius.circular(5)
                  ),
                );
              },
              itemCount: post.reponces!.length,
            ):Container()

          ],
        ),
      ),
    );
  }

  _more(context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(0, 50, 0, 0),
      items: [
        PopupMenuItem(
          value: 'delete',
          child: Text('Delete'),
        ),
        PopupMenuItem(
          value: 'update',
          child: Text('Update'),
        ),
      ],
    ).then((value) {
      if (value == 'delete') {
        // delete the item
      } else if (value == 'update') {
        // update the item
      }
    },);

  }
}
