
import 'package:flutter/material.dart';
import 'package:food_delivery/model_details.dart';

class CategoryModels extends StatelessWidget {
  CategoryModels(this.category,this.docs,{Key? key,}) : super(key: key);
  List<Map<dynamic, dynamic>> docs;
  final category;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category),),
      body:  GridView.builder(

        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 2.0),
        itemBuilder: (context, index) {

          return InkWell(
            onTap: () {

              Navigator.push(context, MaterialPageRoute(builder: (context) => ModelDetails(docs[index]),));
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),

              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage("${docs[index]['image']}"),

                      radius: 40,
                    ),
                  ),
                  Text('${docs[index]['name']}'),


                ],
              ),
            ),
          );
        },
        itemCount:docs.length,
      )

    );
  }
}
