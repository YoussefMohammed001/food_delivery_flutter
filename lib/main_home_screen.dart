import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/cart_screen.dart';
import 'package:food_delivery/fav_screen.dart';
import 'package:food_delivery/home_screen.dart';
import 'package:food_delivery/profile_screen.dart';



class MainHomeScreen extends StatefulWidget {
  MainHomeScreen({Key? key}) : super(key: key);


  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
int index =0;
List<String> tiltes = ["Home","Favorite","Cart","Profile"];
  List<Widget> screens = [HomeScreen(),FavoritScreen(),CartScreen(),ProfileScreen()];

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
   bottomNavigationBar: buildBottomNavigationBar(),
        body: screens[index]
      ),
    );
  }

  Widget buildBottomNavigationBar(){
    return BottomNavigationBar(

      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.orange[500],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black.withOpacity(.60),
      selectedFontSize: 14,
      unselectedFontSize: 14,

      onTap: (value) {
        print(value);
        index = value;
        setState(() {});
      },
      currentIndex: index,
      items: [
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(Icons.home_filled,),
        ),
        BottomNavigationBarItem(
          label: "Cart",
          icon: Icon(Icons.add_shopping_cart_outlined,),
        ),
        BottomNavigationBarItem(
          label: "Favorite",
          icon: Icon(Icons.favorite_border_outlined),
        ),
        BottomNavigationBarItem(
          label: "Profile",
          icon: Icon(Icons.person_outline,),
        ),
      ],
    );
  }
}
