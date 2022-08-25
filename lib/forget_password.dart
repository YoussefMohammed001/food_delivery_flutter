import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  var emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("reset your password"),),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                textInputAction: TextInputAction.done,
                keyboardType:TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "Email"
                ),
                validator: (email){
                  if(email == null || email.isEmpty ){
                    return "Enter Your Email";
                  }
                },
              ),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: () {

                if(_formKey.currentState!.validate()){
                  verifyEmail();
                } else{
                  print("cccccc");

                }
              }, child: Text("Reset Password"))
            ],
          ),
        ),
      ),

    );
  }

  Future verifyEmail() async {
    showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(),),barrierDismissible: false);
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      Utils.showSnackBar('password reset Email Sent');
      Navigator.of(context).popUntil((route) => route.isFirst);

    } on FirebaseAuthException catch(e){
      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();

    }

  }
}
