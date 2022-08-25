import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String firstName= "";
  String lastName= "";
  String email= "";
  String phoneNumber= "";


  Future _getDataFromDatabase() async{
    await FirebaseFirestore.instance.collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get().then((snapshot) async{
          if(snapshot.exists){
            setState(() {
              firstName = snapshot.data()!['first name'];
              lastName = snapshot.data()!['last name'];
              email  = snapshot.data()!['email'];
             phoneNumber =  snapshot.data()!['mobile number'];

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
body: Column(children: [
  
  Text("${firstName! + " "+lastName!}"),

  Center(

    child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(20),
        child: OutlinedButton(onPressed: () => FirebaseAuth.instance.signOut(), child: Text("sign out",style: TextStyle(color: Colors.white),))),
  ),
  Center(
    
    child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(20),
        child: ElevatedButton(onPressed: () => FirebaseAuth.instance.signOut(), child: Text("delete account"))),
  ),

],),
    );
  }
  Future<void> deleteAccount(BuildContext context) async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }


}
