import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/main_home_screen.dart';
import 'package:food_delivery/utils.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  Timer? timer;



  @override
  void initState(){
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
if(!isEmailVerified){
  sendVerificationEmail();

  timer = Timer.periodic(
    Duration(
    seconds: 3
    ),
      (_) => checkEmailVerified(),

  );
}

  }
  @override
  void dispose(){
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async{
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if(isEmailVerified) timer?.cancel();
  }



  Future sendVerificationEmail() async{
  try{
    final user  = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
  } catch (e){
    Utils.showSnackBar(e.toString());
  }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified ?
      MainHomeScreen()
      : Scaffold(
    appBar: AppBar(
    title: Center(child: Text("verify Email")),
    ),
    body: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("A verification Email has been sent to you, Go and verify your email"
          , style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold,fontSize: 22),
          ),
          ElevatedButton(onPressed: () {
            FirebaseAuth.instance.signOut();

          }, child: const Text("Cancel"))



        ],
      ),
    ),

  );

  }

