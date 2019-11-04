import 'package:flutter/material.dart';
import 'package:flutter_login/secondPage.dart';

import 'home.dart';

class DocPa extends StatefulWidget {
  @override
  Doctorpage createState() => Doctorpage();

}


class Doctorpage extends State<DocPa>  {


  List<Widget> bottomNavIconList(context) {
    return [
      new GestureDetector(
        onTap: () {
          Navigator.of(context).push(createRoute2());
        },
        child: Column(

          children: <Widget>[

            ImageIcon(
              new AssetImage("assets/images/home.png"),
              color: Colors.white70,
              size: 34.0,
            ),


          ],
        ),
      ),
      new GestureDetector(
        onTap: () {
          Navigator.of(context).push(createRoute4());
        },
        child: Column(
          children: <Widget>[
            ImageIcon(
              new AssetImage("assets/images/r.png"),
              color: Colors.white70,
              size: 34.0,
            ),


          ],
        ),
      ),
      new GestureDetector(
        onTap: () {
          Navigator.of(context).push(doctorpaGe());
        },
        child: Column(
          children: <Widget>[
            ImageIcon(
              new AssetImage("assets/images/doctor.png"),
              color: Colors.amber,
              size: 34.0,
            ),


          ],
        ),
      ),
    ];
  }


  int _currentIndex = 0;
  Widget build(BuildContext context) {

    List<Widget> bottomNavIconList1 = bottomNavIconList(context);


    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Material(

        child: Scaffold(
          body: new Center(
            child: new Text("PAGE CURRENTLY UNDER DEVELOPMENT!"),

          ),
          bottomNavigationBar: Container(
            height: 50.0,
            decoration: BoxDecoration(color: Color(0xff2e2e6b), boxShadow: [
              BoxShadow(
                  color: Colors.black12.withOpacity(0.065),
                  offset: Offset(0.0, -3.0),
                  blurRadius: 10.0)
            ]),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: bottomNavIconList1.map((item) {
                  var index = bottomNavIconList1.indexOf(item);
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex = index;

                        });
                      },
                      child: bottomNavItem(item, index == _currentIndex),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),

      ),

    );
  }

  Route createRoute2() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => FavoriteWidget2(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset.zero;
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },

    );
  }

  Route doctorpaGe() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => DocPa(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset.zero;
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },

    );
  }


  Route createRoute4() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SecondeP(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset.zero;
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },

    );
  }

}