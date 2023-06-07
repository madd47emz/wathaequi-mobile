import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wathaequi/models/Paper.dart';
import 'package:wathaequi/view_models/document_vm.dart';
import 'package:wathaequi/views/res/colors.dart';

class DocCard extends StatelessWidget {
  final Paper paper;
  final DocViewModel docViewModel;
  const DocCard({Key? key, required this.paper, required this.docViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),

        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(paper.name,style: TextStyle(color: darkColor,fontSize: 18),),

            subtitle: Text('expire in: ${paper.expiration.year}/${paper.expiration.month}/${paper.expiration.day}',style: TextStyle(color: darkColor.withOpacity(0.8),fontSize: 16),),
            leading: Icon(paper.type=="simple"?Icons.contact_page_rounded:Icons.folder,color: mainColor,size: 40,),
            onTap: ()async {
              Directory? appDocDir = await getExternalStorageDirectory();
              String appDocPath = appDocDir!.path;

              // Create the file path
              String filepath = '$appDocPath/naissance.pdf';

              // Check if the file exists
              bool fileExists = await File(filepath).exists();
              if(!fileExists){
                filepath = await docViewModel.getNaissancePdf();
                filepath!="error"?
                OpenFile.open(filepath)
                    :ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error'),
                  ),
                );}else{
                OpenFile.open(filepath);}


            },
            trailing: Icon(paper.type=="simple"?Icons.open_in_new:Icons.account_balance),


          ),
        ),
      ),
    );
  }
}
