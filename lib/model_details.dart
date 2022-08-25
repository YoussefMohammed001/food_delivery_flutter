import 'package:flutter/material.dart';

class ModelDetails extends StatelessWidget {
  ModelDetails(this.products,{Key? key}) : super(key: key);
  Map products;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body:Column(
          children: [
           Stack(
             alignment: AlignmentDirectional.bottomCenter,
             children: [
               Container(
                   width: double.infinity,
                   height: 300,
                   child: Image.network('${products['image']}',fit: BoxFit.fill,)),
               Container(
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10), color: Colors.orange),

                 height: 50,

                 padding: EdgeInsets.all(10),
                 margin: EdgeInsets.only(top: 50,right: 20,left: 20,bottom: 10),
                 child: Row(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text('${products['name']}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),),
                     Spacer(),
                     Text('${products['price']}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),)

                   ],
                 ),
               )
             ],
           ),
            Spacer(),
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(

                      padding: EdgeInsets.all(10),
                      child: OutlinedButton(onPressed: () {

                      }, child: Text('Order',style: TextStyle(color: Colors.orange),)),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30), color: Colors.orange),


                    height: 40,

                    margin: EdgeInsets.all(20),
                    child: IconButton(onPressed: () {

                    }, icon: Icon(Icons.favorite_border,color: Colors.white,)),
                  )
                ],
              ),
            )



          ],
        ),
      ),
    );



  }



}


