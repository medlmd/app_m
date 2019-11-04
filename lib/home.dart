import 'package:flutter/material.dart';
import 'package:flutter_login/secondPage.dart';
import 'package:flutter_login/type.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'database.dart';
import 'doctorePage.dart';

class FavoriteWidget2 extends StatefulWidget {
  @override
  Home createState() => Home();

}

class Home extends State<FavoriteWidget2> {
  var ads = [];
  var news=[];
  var a = false;
  var list=[];
  WebSiteDatabase db = WebSiteDatabase();
  var error = false;
  List<Widget> newsWidgets = [
    const Padding(padding: EdgeInsets.all(4.0),),
    Center(child: new SizedBox(
      width: 32, height   : 32, child: CircularProgressIndicator(
      strokeWidth: 4,
      valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff006699)),),)),
    Padding(padding: EdgeInsets.all(8),),
//    new Text("جاري التحميل", style: new TextStyle(fontFamily: 'hacen',fontSize: 32, fontWeight: FontWeight.bold),),
    Padding(padding: EdgeInsets.all(8),),
  ];


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
              color: Colors.amber,
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
              color: Colors.white70,
              size: 34.0,
            ),


          ],
        ),
      ),
    ];
  }



  final TextEditingController _searchQuery = new TextEditingController();
  Home(){
    _searchQuery.addListener(() {
      print(_searchQuery.text);
      if(_searchQuery.text.length>0){
        setState(() {

          newsWidgets = search(list, _searchQuery.text);
          setup();

        });
      }
      if(_searchQuery.text.length==0){
        print("vide");
        setState(() {
          newsWidgets=[];
          getData();
          setup();
        });

      }
    });

  }

  List<dynamic> search(var l, key){
    var ar = [];
    for (var i3 in l){
      if(i3['author'].contains(key)){
        ar.add(i3);
        print(key);
      }
      else{

        print("else");

      }


    }
    return ar;
  }





  getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://maulearn.com/php/adsM.php"),
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      var map = json.decode(response.body);
      for (var i2 in map) {
        ads.add(i2);
      }
    }
    else {
      print("Pas de reponse");
    }

         response = await http.get(
            Uri.encodeFull(
                "http://maulearn.com/phpM/GetPublication.php"),
            headers: {"Accept": "application/json"});

        if (response.statusCode == 200) {
          var map = json.decode(response.body);
          for (var i2 in map) {

            db.insertNew(New(
              author: i2['author'],
              title: i2["Title"],
              desc: i2["Descr"],
              img: i2["Image"],
              time: i2['Time'],
              nbLike: i2['nbLike']
            ));

           // print(i2);
          }
          list=map;
        }
        else {
          print("Pas de reponse");
          error = true;
        }
      }


  getAllNews() async{
    news = await db.getAllNews();
  }



  setup() async {
    if (error) {
      newsWidgets.add(new Column(
        children: <Widget>[
          new Padding(padding: EdgeInsets.only(top: MediaQuery
              .of(context)
              .size
              .height / 2 - 250)),
          new Text("", style: TextStyle(
              fontFamily: 'hacen', fontSize: 32, color: Colors.black87),),
          new Padding(padding: EdgeInsets.only(top: 32)),
          RaisedButton(
            onPressed: () {
    },
            color: Color(0xff006699),
            padding: EdgeInsets.symmetric(horizontal: 64.0, vertical: 4),
            child: Text("", style: TextStyle(
                color: Colors.white, fontSize: 42.0, fontFamily: 'hacen'),),
          ),
        ],
      ));
      return;
    }
    await getData();
    news = await db.getAllNews();
    if (!a) {
      a = true;
      newsWidgets = [];
    }
    var ads_counter = 0;

    for (New n in news) {
    ProductCard p = new ProductCard(
          0xFFFFFFFF,
          n.img,
          n.title,
          n.desc,
          n.author,
          ads[3],
          this,
          n.time);
      newsWidgets.add(p);

      switch (ads_counter) {
        case 0:
          newsWidgets.add(Advertisement(ads[0]['image'], ads[0]['url']));
          break;
        case 2:
          newsWidgets.add(Advertisement(ads[1]['image'], ads[1]['url']));
          break;
        case 4:
          newsWidgets.add(Advertisement(ads[2]['image'], ads[2]['url']));
          break;
      }
      ads_counter++;
    }
    setState(() {
      var loaded = true;
    });
  }


  @override
  void initState() {

    super.initState();
    db.deleteNews();
    setup();
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> bottomNavIconList1 = bottomNavIconList(context);

    return Scaffold(

      backgroundColor: Color(0xFFEEEEEE),

      appBar: PreferredSize(
        preferredSize: Size(null, 132),
        child: Container(
          color: Color(0xff2e2e6b),
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(14),),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16.0, left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[Text("fil d'actualite", style: TextStyle(color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold),)
                    ,Image.asset("assets/images/yata.png", height: 37,),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: TextField(
                  controller: _searchQuery,
                  textAlign: TextAlign.left,

                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search,color: Colors.black87,),
                      labelText: 'Recherche'
                  ),
                ),
              ),
            ],
          ),
        ),

      ),

      body:Container (
            child: Flex(
                  direction: Axis.vertical,
                  children: <Widget> [

                    Expanded(
                      child: SingleChildScrollView(

                        child: Column(

                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(top: 32),),


                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
                              child: new Column(
                                  children: <Widget>[
                                    Column(
                                      children: newsWidgets,
                                    ),
                                  ]
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ]
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


    );
  }

  bottomNavItem(Widget item, bool isSelected) => Container(
    decoration: BoxDecoration(
        boxShadow: isSelected
            ? [
          BoxShadow(
              color: Colors.red.withOpacity(0.02),
              offset: Offset(0.0, 5.0),
              blurRadius: 10.0)
        ]
            : []),
    child: item,
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

class ClipingClass3 extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return null;
  }


}

class ProductCard extends StatelessWidget {
  int cardColor;
  var imgUrl, title, author, ad, a;
  var url1;
  var desc;
  var ims, time, logo, video;

  ProductCard(
      this.cardColor, this.imgUrl, this.title, this.desc, this.author, this.ad, this.a,this.time);


  @override
  Widget build(BuildContext context) {
    void _showOverlay(BuildContext context) {

    }

    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: GestureDetector(
        onTap: () => _showOverlay(context),
        child: Container(
//        width: double.infinity,
//        height: 320.0,
          width: 490,
          decoration: BoxDecoration(
              color: Color(cardColor),
              borderRadius: BorderRadius.circular(0),
              border: Border.all(color: Colors.grey.withOpacity(.3), width: .2)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 8.0,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(author, style: TextStyle(fontFamily: 'dd', color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
                    Text(time, style: TextStyle(fontFamily: 'dd', color: Colors.black45, fontSize: 16),),
                  ],
                ),
              ),

              Padding(padding: EdgeInsets.all(4),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title,textAlign: TextAlign.left,
                    maxLines: 2,
                    style:
                    TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, fontFamily: "hacen")),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 150,
                      child: Text(desc, maxLines: 4, style: TextStyle(fontFamily: 'dd', color: Colors.black, fontSize: 16),)
                    ),
                    Image.network(imgUrl, width: 96, height: 96, fit: BoxFit.fill,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("32 j'aime", style: TextStyle(color: Colors.black, fontSize: 16),),
                    Row(
                      children: <Widget>[
                        GestureDetector(
                            onTap: (){
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.add),
                            )
                        ),
                        GestureDetector(
                            onTap: (){
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.favorite),
                            )
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class Advertisement extends StatelessWidget {
  var imgUrl, url1;

  Advertisement(
      this.imgUrl, this.url1);

  @override
  Widget build(BuildContext context) {
    void _showOverlay(BuildContext context) {
      if (url1 == ""){
        print("");
        return;
      }

    }

    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: GestureDetector(
        onTap: () => _showOverlay(context),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.network(imgUrl, height: 200, fit: BoxFit.cover,),
            ],
          ),
        ),
      ),
    );
  }
}

