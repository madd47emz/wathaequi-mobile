import 'package:flutter/material.dart';
import 'package:wathaequi/views/res/colors.dart';
import 'package:wathaequi/views/util/documentCard.dart';

import '../models/Paper.dart';
import '../view_models/document_vm.dart';

class Documents extends StatefulWidget {
  List<Paper> paper;
  final DocViewModel docViewModel;
  Documents({Key? key,required this.paper, required this.docViewModel}) : super(key: key);

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36,vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Documents",
                    style: TextStyle(
                        color: darkColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 35),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        size: 30,
                        color: mainColor,
                      )),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return DocCard(paper:widget.paper[index],docViewModel: widget.docViewModel,);
                },
                itemCount: widget.paper.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
