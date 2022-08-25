import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/category%20models.dart';
import 'package:food_delivery/model_details.dart';

import 'package:food_delivery/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String firstName = "";
  String lastName = "";
  String email = "";
  String phoneNumber = "";

  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          firstName = snapshot.data()!['first name'];
          lastName = snapshot.data()!['last name'];
          email = snapshot.data()!['email'];
          phoneNumber = snapshot.data()!['mobile number'];
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                height: 130,
                color: Colors.orange,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin:
                            EdgeInsets.only(left: 10, top: 10, bottom: 10),
                        child: Text(
                          "Welcome,",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 33,
                              fontWeight: FontWeight.bold),
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          "${firstName!}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 33,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
              buildCustomSearch(),
            ],
          ),
          SizedBox(
            height: 10,
            child: Container(
              color: Colors.orange,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.all(5),
                  child: Text(
                    "Categories",
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  )),
              buildCategoryList(),
              Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    "Recommended Dishes",
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  )),
              buildBestItemsList()
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCustomSearch() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.white),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: " Search",
            hintStyle: TextStyle(color: Colors.orange),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.orange,
            ),
            border: InputBorder.none),
      ),
    );
  }

  Widget buildCategoryList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("category").snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Container(
                height: 80,
                margin: EdgeInsets.all(10),
                child: Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      return categoryItem(index, data);
                    },
                  ),
                ),
              ),
            ],
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }



  Widget categoryItem(index, data) {
    return InkWell(
      onTap: () {
        String category = "";
        switch (index) {
          case 0:
            category = "Appetizers";
            break;
          case 1:
            category = "Beef";
            break;
            case 2:
            category = "Chicken";
            break;
          case 3:
            category = "Drinks";
            break;
            case 4:
            category = "Main Dishes";
            break;
            case 5:
            category = "Pizza";
            break;
          case 6:
            category = "Sea Food";
            break;


        }
        FirebaseFirestore.instance.collection('category')
            .doc(category)
            .collection(category)
            .get()
            .then((value) {
              List<Map> docs =[];
          for (var doc in value.docs) {
               docs.add(doc.data());
          }
          Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryModels(category,docs)));
        });

           },
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(data['image']),
                radius: 30,
              ),
              Text(data['name']),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBestItemsList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("best").snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {

          return SingleChildScrollView(
            child: Expanded(
              child: Container(
                height: 420,

                width: double.infinity,


                child:
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2.0,
                      mainAxisSpacing: 2.0),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index];

                    return InkWell(
                      onTap: () {
                        String category = "best items";
                        FirebaseFirestore.instance.collection('best').get()
                            .then((value) {
                          List<Map<dynamic, dynamic>> docs = [];
                          for (var doc in value.docs) {

                            docs.add(doc.data());
                          }
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ModelDetails(docs[index])));

                          //m
                        });

    },
    child: Column(
                        children: [

                          CircleAvatar(
                            backgroundImage: NetworkImage(data['image']),
                            radius: 40,
                          ),
                          Text(data['name']),
                        ],
                      ),
                    );
                  },
                  itemCount: snapshot.data!.docs.length,
                ),
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
