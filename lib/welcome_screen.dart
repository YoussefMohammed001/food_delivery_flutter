

import 'package:flutter/material.dart';

import 'package:food_delivery/login_register_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
          body: welcomeScreen()


      ),
    );
  }

  Widget welcomeScreen(){
    return Column(


      children: [
        Container(
          margin: EdgeInsets.all(10),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Text("Food App", style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold,fontSize: 30),),
                Spacer(),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(),


                    onPressed: () {
                      checkLoginScreen = true;
                      checkRegisterScreen = false;
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginAndRegisterScreen(),));

                    }, child: Container(
                    padding: EdgeInsets.all(20),
                    child: Text("SIGN IN", style: TextStyle(color: Colors.orange,fontSize: 22),)))
              ],
            ),
          ),
        ),

        Expanded(child:
        Container(


            height: double.infinity,
            child: Stack(
              children: [
                Container(

                    width: double.infinity,
                    height: double.infinity,

                    child:
                    Image.asset("images/welcome.jpg", fit: BoxFit.fill,)
                ),
                Column(
                  children: [
                    Container(
                        margin: EdgeInsets.all(10),

                        child: Text("STAY HOME WE WILL DELIVER IT TO YOU",style: TextStyle(fontSize: 38,color: Colors.white,fontWeight: FontWeight.bold),)),
                    Spacer(),

                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 50,left: 20,right: 20),

                      child: ElevatedButton(onPressed: () {
                        checkLoginScreen = false;
                        checkRegisterScreen = true;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginAndRegisterScreen(),));
                      }, child: Container(
                          padding: EdgeInsets.all(10),
                          child: const Text("GET STARTED",style: TextStyle(color: Colors.white,fontSize: 22),))),
                    )
                  ],
                )

              ],
            )

        )),

      ],



    );
  }
}
