import 'package:flutter/material.dart';
import 'package:wathaequi/views/res/colors.dart';

import '../../models/Post.dart';

class PostView extends StatelessWidget {
  final Post post;

  const PostView({super.key, required this.post});


  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black.withOpacity(0.25),
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: darkColor,
          width: 1.0,
        ),
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
                  children: [
                    CircleAvatar(
                      backgroundColor: mainColor,
                      child: Icon(Icons.person,color: Colors.white,),
                    ),
                    SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.fullNameCitizen!,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          post.datePublication!,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey[600],
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
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),

            Image.network("https://images.theconversation.com/files/233448/original/file-20180824-149463-1hzm435.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop")
            ,
            SizedBox(height: 8,),
            Text(
              'Replies',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            reply!=""?
            Container(
              width: double.infinity,
              child: Center(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(reply,style: TextStyle(color: darkColor,fontSize: 16),),
              )),
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(5)
              ),
            ):Container(),
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
