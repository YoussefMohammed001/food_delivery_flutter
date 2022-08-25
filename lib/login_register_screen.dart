import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/forget_password.dart';

import 'package:food_delivery/main.dart';
import 'package:food_delivery/main_home_screen.dart';
import 'package:food_delivery/my_text_field.dart';
import 'package:food_delivery/utils.dart';
import 'package:food_delivery/verifyEmail.dart';
import 'package:food_delivery/welcome_screen.dart';
import 'package:image_picker/image_picker.dart';
bool isNotVisible = true;
bool  checkLoginScreen = true;
bool checkRegisterScreen = false;


class LoginAndRegisterScreen extends StatefulWidget {
  LoginAndRegisterScreen({Key? key}) : super(key: key);

  @override
  State<LoginAndRegisterScreen> createState() => _LoginAndRegisterScreenState();
}

class _LoginAndRegisterScreenState extends State<LoginAndRegisterScreen> {

  final ImagePicker imagePicker = ImagePicker();
  XFile? photo;

  void pickImageCamera() async {
    photo = await imagePicker.pickImage(source: ImageSource.camera,imageQuality: 25);
    setState(() {
    });

  }
  void pickImageGallery() async {
    photo = await imagePicker.pickImage(source: ImageSource.gallery,imageQuality: 25);
    setState(() {
    });

  }

  var emailController = TextEditingController();
  var registerEmailController = TextEditingController();
  var passwordController = TextEditingController();
  var registerPasswordController = TextEditingController();
  var registerPasswordControllerConfirmation = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var registerMobileNumberController = TextEditingController();

  @override
  void dispose(){

    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Form(
        key: _formKey,
        child: Scaffold(

          body: login(),



        ),
      ),

    );
  }
  Widget login(){
    return Stack(

      children: [

        Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset("images/login.jpg", fit: BoxFit.fill,)

        ),




        SingleChildScrollView(

          child:
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10,top: 20),
                alignment: AlignmentDirectional.topStart,
                child:
                IconButton(onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen(),));
                }, icon: Icon(Icons.arrow_back_ios_new,color: Colors.orange,size: 40,)),
              ),

              Container(
                margin: EdgeInsets.only(right: 20,left: 20,),
                child: Row(

                  children: [

                    InkWell(
                        onTap: (){
                          checkLoginScreen = true;
                          checkRegisterScreen = false;
                          setState(() {

                          });
                        },
                        child: Text("SIGN IN",style: TextStyle(color: checkLoginScreen ? Colors.orange: Colors.white ,fontSize: 40,fontWeight: FontWeight.bold,))),
                    SizedBox(width: 20,),
                    InkWell(

                        onTap: (){
                          checkRegisterScreen = true;
                          checkLoginScreen = false;
                          setState(() {

                          });
                        },

                        child: Text("SIGN UP",style: TextStyle(color: checkRegisterScreen ? Colors.orange: Colors.white ,fontSize: 40,fontWeight: FontWeight.bold,))),

                  ],
                ),
              ),
              Visibility(
                  visible: checkLoginScreen,
                  child: loginScreen()),


              Visibility(
                  visible:  checkRegisterScreen,
                  child: registerScreen()),
            ],
          ),
        )





      ],
    );
  }

  Widget loginScreen(){

    return Container(

      width: double.infinity,
      color: Colors.white,

      margin: EdgeInsets.only(right: 20,left: 20,top: 20),
      padding: EdgeInsets.only(left: 10,right: 10,top: 10),
      child: Column(
        children: [


          MyTextField(
            controller: emailController,
            validator: (value) {
              if(value == null || value.isEmpty){
                return"please enter your email";

              }
            },

            obscure: false,keyBoardType: TextInputType.text, lableText: "Email", textInputAction: TextInputAction.next,prefxi: Icon(Icons.email,color: Colors.orange,),),
          SizedBox(height: 10,),
          MyTextField(

            controller: passwordController,
            validator: (value) {
              if(value == null || value.isEmpty){
                return"please enter your password";

              }
            },
            obscure: isNotVisible,keyBoardType: TextInputType.visiblePassword, lableText: "Password", textInputAction: TextInputAction.done,
            prefxi: Icon(Icons.password,color: Colors.orange,),

            suffixIcon: IconButton(onPressed: () {
            isNotVisible = !isNotVisible;
            setState(() {});

          }, icon: Icon(isNotVisible ? Icons.visibility_off_outlined : Icons.visibility ,color: Colors.orange,)),


          ),
          SizedBox(height: 10,),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 10),
            child: ElevatedButton(onPressed: () {

              if(_formKey.currentState!.validate()){
                signIn();

              } else{

              }

            },  child: Container(
                padding: EdgeInsets.all(10),
                child: Text("SIGN IN", style: TextStyle(color: Colors.white,fontSize: 22),))),
          ),
          Container(
            width: double.infinity,
            child: TextButton(onPressed: () {


              Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPassword(),));


            },  child: Container(
                alignment: Alignment.topRight,

                child: Text("Forget Password", style: TextStyle(color: Colors.orange,fontSize: 18),))),
          ),




        ],
      ),
    );
  }
  Future signIn() async{
    showDialog(context: context,
        builder: (context)
        => Center(child: CircularProgressIndicator(),)
        ,barrierDismissible: false);
    try{

      await FirebaseAuth.instance.signInWithEmailAndPassword(email: "${emailController.text.trim()}", password: "${passwordController.text.trim()}");
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainHomeScreen(),)

      );
    } on FirebaseAuthException catch (e){
      Utils.showSnackBar(e.message);


    }
    navigatorKey.currentState!.popUntil((route)=> route.isFirst);
  }






  Widget registerScreen(){


    return Container(

      width: double.infinity,
      color: Colors.white,

      margin: EdgeInsets.only(right: 20,left: 20),
      padding: EdgeInsets.only(left: 10,right: 10,top: 10),
      child: Column(
        children: [


        // // Stack(
        //   // alignment: AlignmentDirectional.bottomEnd,
        //    //children: [
        //      //CircleAvatar(
        //        //  radius: 50,
        //        //backgroundImage: photo != null ?
        //        FileImage(File(photo!.path)) : null,
        //        child: photo == null?
        //        const Icon(Icons.person)
        //            : null
        //      ),
        //      Container(
        //        margin: EdgeInsets.only(top: 30),
        //        child: IconButton(onPressed: () {
        //          showModalBottomSheet<void>(
        //              context: context,
        //              builder: (BuildContext context) {
        //            return Container(
        //              height: 200,
        //              color: Colors.orangeAccent,
        //              child: Center(
        //                child: Row(
        //                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //
        //                  children: <Widget>[
        //                 InkWell(
        //                   onTap: (){
        //                     pickImageCamera();
        //
        //              },
        //                   child: Column(
        //                     crossAxisAlignment: CrossAxisAlignment.center,
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     children: [
        //                       Icon(
        //                         Icons.camera_alt_outlined,color: Colors.white,size: 33,
        //                       ),
        //                       Text("From Camera",style: TextStyle(color: Colors.white,fontSize: 22),)
        //                     ],
        //                   ),
        //                 ),
        //
        //                 InkWell(
        //                   onTap: (){
        //                     pickImageGallery();
        //                   },
        //                   child: Column(
        //                     crossAxisAlignment: CrossAxisAlignment.center,
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     children: [
        //                       Icon(
        //                         Icons.photo,color: Colors.white,size: 33,
        //                       ),
        //                       Text("From Gallery",style: TextStyle(color: Colors.white,fontSize: 22),)
        //                     ],
        //                   ),
        //                 ),
        //                  ],
        //                ),
        //              ),
        //            );
        //          },);
        //
        //        }, icon: Icon(Icons.camera_alt_outlined,color: Colors.white,)),
        //      )
        //
        //    ],
        //  ),


          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: MyTextField(
                  onSaved: (value){
                    firstNameController.text = value!;
                  },

                  controller: firstNameController,

                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return"please enter your first name";

                    }
                  },


                  obscure: false,keyBoardType: TextInputType.text, lableText: "First Name", textInputAction: TextInputAction.next,prefxi: Icon(Icons.person,color: Colors.orange,),),
              ),
              SizedBox(width: 5,),
              Expanded(
                child: MyTextField(
                  onSaved: (value){
                    lastNameController.text = value!;
                  },

                  controller: lastNameController,

                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return"please enter your last name";

                    }
                  },


                  obscure: false,keyBoardType: TextInputType.text, lableText: "Last Name", textInputAction: TextInputAction.next,prefxi: Icon(Icons.person,color: Colors.orange,),),
              ),
            ],
          ),
          SizedBox(height: 10,),
          MyTextField(
            onSaved: (value){
              registerEmailController.text = value!;
            },
            controller: registerEmailController,
            validator: (value) {
              if(value == null || value.isEmpty){
                return"please enter your email";


              }
            },

            obscure: false,keyBoardType: TextInputType.text, lableText: "Email", textInputAction: TextInputAction.next,prefxi: Icon(Icons.email,color: Colors.orange,),),
          SizedBox(height: 10,),
          MyTextField(
            onSaved: (value){
              registerEmailController.text = value!;
            },
            controller: registerMobileNumberController,
            validator: (value) {
              if(value == null || value.isEmpty){
                return"please enter your mobile number";
              } if(value.length <11){
                return "enter a valid mobile number";
              }
            },

            obscure: false,keyBoardType: TextInputType.text, lableText: "mobile number", textInputAction: TextInputAction.next,prefxi: Icon(Icons.phone_android_outlined,color: Colors.orange,),),
          SizedBox(height: 10,),

          MyTextField(
            onSaved: (value){
              registerPasswordController.text = value!;
            },
            controller: registerPasswordController,

            validator: (password) {
              if(password == null || password.isEmpty){
                return"please enter your password";

              } if(password.length <= 6){
                return "password length must be > 6";
              }
            },
            obscure: isNotVisible,keyBoardType: TextInputType.visiblePassword, lableText: "Password", textInputAction: TextInputAction.done,prefxi: Icon(Icons.password,color: Colors.orange,),suffixIcon: IconButton(onPressed: () {
            isNotVisible = !isNotVisible;
            setState(() {
            });
          }, icon: Icon(isNotVisible ? Icons.visibility_off_outlined : Icons.visibility ,color: Colors.orange,)),),
          SizedBox(height: 10,),
          MyTextField(

            onSaved: (value){
              registerPasswordControllerConfirmation.text = value!;
            },


            controller: registerPasswordControllerConfirmation,
            validator: (value ) {
              if(value == null || value.isEmpty){
                return"please confirm your password";
              } if(registerPasswordController.text != registerPasswordControllerConfirmation.text){
                return "Password doesn't match";
              }
            },
            obscure: isNotVisible,keyBoardType: TextInputType.visiblePassword, lableText: "Confirm Password", textInputAction: TextInputAction.done,prefxi: Icon(Icons.password,color: Colors.orange,),suffixIcon: IconButton(onPressed: () {
            isNotVisible = !isNotVisible;
            setState(() {
            });
          }, icon: Icon(isNotVisible ? Icons.visibility_off_outlined : Icons.visibility ,color: Colors.orange,)),),
          SizedBox(height: 10,),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 10,bottom: 10),
            child: ElevatedButton(onPressed: () {

              if(_formKey.currentState!.validate()){
                signUp();
              } else{
                print("cccccc");
              }

            },  child: Container(
                padding: EdgeInsets.all(10),
                child: Text("SIGN UP", style: TextStyle(color: Colors.white,fontSize: 22),))),
          ),




        ],
      ),
    );
  }


  Future signUp() async{

    showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(),),barrierDismissible: false);
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: "${registerEmailController.text.trim()}", password: "${registerPasswordController.text.trim()}");
      String email = registerEmailController.text.trim();
      String firstName = firstNameController.text.trim();
      String lastname = lastNameController.text.trim();
      String mobileNumber = registerMobileNumberController.text.trim();
      Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyEmail(),)
      ).then((value) async{
        User? user = FirebaseAuth.instance.currentUser;
        await FirebaseFirestore.instance.collection("users").doc(user?.uid).set({
          "uid": user?.uid,
          "first name" :firstName ,
          "last name": lastname,
          "email": email,
          "mobile number" : mobileNumber

        });
      });
    } on FirebaseAuthException catch (e){
      Utils.showSnackBar(e.message);

    }

    navigatorKey.currentState!.popUntil((route)=> route.isFirst);
  }


}