import 'package:flutter/material.dart';
import 'package:wathaequi/models/Nearby.dart';
import 'package:wathaequi/views/res/colors.dart';

class NearByPlacesScreen extends StatefulWidget {
  NearbyPlacesResponse places;
  NearByPlacesScreen({Key? key,required this.places}) : super(key: key);

  @override
  State<NearByPlacesScreen> createState() => _NearByPlacesScreenState();
}

class _NearByPlacesScreenState extends State<NearByPlacesScreen> {
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
                    "City halls",
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
            widget.places.results!.length>0?Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),

                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(widget.places.results![index].name!),
                          subtitle: Text(widget.places.results![index].vicinity!),
                          leading: Icon(Icons.account_balance, color: widget.places.results![index].openingHours?.openNow!=null?Colors.green:Colors.red,),
                          onTap: (){
                            Navigator.pop(context,widget.places.results![index].geometry!.location);
                          },
                          trailing: Icon(Icons.directions),


                        ),
                      ),
                    ),
                  );
                },
                itemCount: widget.places.results!.length,
              ),
            ):Text("There is No Nearby City halls",style: TextStyle(fontSize: 20),)
          ],
        ),
      ),
    );
  }
}
