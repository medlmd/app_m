import 'package:flutter/material.dart';

import 'home.dart';

class SecondeP extends StatefulWidget {
  @override
  PageSeconde createState() => PageSeconde();

}


class PageSeconde extends State<SecondeP>{

  int _currentIndex = 0;

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
              color: Colors.amber,
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
              color: Colors.white70,
              size: 34.0,
            ),


          ],
        ),
      ),
    ];
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

  var imgs = ['assets/images/a.png','assets/images/b.png','assets/images/c.png','assets/images/d.png','assets/images/e.png','assets/images/f.png',];
  var txts = ['ECG','Dermatologie','Rx thorax','Orthopédie','Endocrino','Staff médical',];
  @override
  Widget build(BuildContext context) {
    List<Widget> bottomNavIconList1 = bottomNavIconList(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(null, 100),

              child: new Container(
                height: 80,
                padding: EdgeInsets.only(
                    top: 30.0, left: 16.0, right: 9.0),
                decoration: BoxDecoration(
                  color: Color(0xff2e2e6b),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Image.asset("assets/images/t.png", height: 60, color: Color(0xFFFFFFFF),),
                    Image.asset("assets/images/t.png", height: 60, color: Color(0xFFFFFFFF),),
                  ],
                ),
              )

        ),

        body: Center(
          child: Container(
            color: Colors.white10,
            child: GridView.count(
    padding: const EdgeInsets.all(10.0),
              crossAxisCount: 2,
              // Generate 100 widgets that display their index in the List.
              children: List.generate(6,(index) {
                return GestureDetector(
                  onTap: (){

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          children: <Widget>[

                            Image.asset(imgs[index] , width: MediaQuery.of(context).size.width/2-100,),
                            Text(txts[index],
                              style: Theme.of(context).textTheme.headline,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
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
    );
  }

  bottomNavItem(Widget item, bool isSelected) => Container(
    decoration: BoxDecoration(
        boxShadow: isSelected
            ? [
          BoxShadow(
              color: Colors.black12.withOpacity(0.02),
              offset: Offset(0.0, 5.0),
              blurRadius: 10.0)
        ]
            : []),
    child: item,
  );

}


