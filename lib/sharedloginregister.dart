import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_login/secondPage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';

import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}


class _LoginState extends State<Login> {



  String email, password;
  final _key = new GlobalKey<FormState>();
  var data='';
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }


  bool test = false;
  login() async {
    print(emailController.text);
    if (emailController.text != null && passwordController.text != null) {
      email = emailController.text;
      password = passwordController.text;


      final response = await http.get(
          Uri.encodeFull("http://maulearn.com/phpM/login.php?email=${email} & password=${password}"),
          headers: {"Accept": "application/json"});

      if (response.statusCode == 200) {
        //print(response.body);
        setState(() {

          var convertDataToJson = response.body.toString();
          data = convertDataToJson;
          //print(data[0]['Email']);
          print(data.length);
          if(data.length!=1){

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FavoriteWidget2()),
            );
          }

        });
      }
      else{
        print("Pas de reponse");
      }
    }


  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Eror "),
          content: new Text("Email ou mot de passe incorrect"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Login()),
                );
              },
            ),
          ],
        );
      },
    );
  }

setup() async {
  await login();
}

  @override
  void initState() {

    super.initState();

    setup();
  }


  @override
  Widget build(BuildContext context) {


        return Scaffold(
          backgroundColor: Colors.blueGrey[500],
          body: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(15.0),
              children: <Widget>[
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
//            color: Colors.grey.withAlpha(20),
                    color: Colors.blueGrey[500],
                    child: Form(
                      key: _key,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/images/yata.png'),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            height: 50,
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 30.0),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),

                          //card for Email TextFormField
                          Card(
                            elevation: 6.0,
                            child: TextFormField(
                              controller: emailController,
                              validator: (e) {
                               if (e.isEmpty) {
                                  return "Please Insert Email";
                                }
                              },
                              onSaved: (e) => email = e,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding:
                                    EdgeInsets.only(left: 20, right: 15),
                                    child:
                                    Icon(Icons.person, color: Colors.black),
                                  ),
                                  contentPadding: EdgeInsets.all(18),
                                  labelText: "Email"),
                            ),
                          ),

                          // Card for password TextFormField
                          Card(
                            elevation: 6.0,
                            child: TextFormField(
                              controller: passwordController,
                              validator: (e) {
                                if (e.isEmpty) {
                                  return "Password Can't be Empty";
                                }
                              },
                              obscureText: _secureText,
                              onSaved: (e) => password = e,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                labelText: "Password",
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 20, right: 15),
                                  child: Icon(Icons.phonelink_lock,
                                      color: Colors.black),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: showHide,
                                  icon: Icon(_secureText
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                                contentPadding: EdgeInsets.all(18),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 12,
                          ),

                          FlatButton(
                            onPressed: null,
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.all(14.0),
                          ),

                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(
                                height: 44.0,
                                child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(15.0)),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    textColor: Colors.white,
                                    color: Colors.blue[900],
                                    onPressed: () {
                                      setup();


                                    }),
                              ),
                              SizedBox(
                                height: 44.0,
                                child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(15.0)),
                                    child: Text(
                                      "Register",
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    textColor: Colors.white,
                                    color: Colors.blue[900],
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Rgst()),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );



    }
  }




class Rgst extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Rgst> {
  String name, email, mobile, password,poste,choix;
  final _key = new GlobalKey<FormState>();

String dropdownValue = 'Médecins généralistes';

var specialite;
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }
  File file;
  TextEditingController fullNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController postController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  bool Registred=false;



  String validateName(String value) {
    if (value.length < 2)
      return 'Le nom doit avoir plus de 1 caractère';
    else
      return null;
  }

  String validatePost(String value) {
    if (value.length < 2)
      return 'Le post doit avoir plus de 1 caractère';
    else
      return null;
  }

  static var  patttern = r'(^[0-9])';
  RegExp regExp = new RegExp(patttern);


  String validatePassowrd(String value) {
// Indian Mobile number are of 8 digit only
    if (value.length <6)
      return 'Le mot de pass doit être composé de 6 chiffres';
    else
      return null;
  }


  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Entrez une adresse email valide';
    else
      return null;
  }


  sendInfo() async {

      if(validateName(fullNameController.text)==null && validateEmail(emailController.text)==null && file!=null) {
        var base64Image = base64Encode(file.readAsBytesSync());
        print(base64Image);
        String fileName = file.path
            .split("/")
            .last;
        name = fullNameController.text;
        email = emailController.text;
        mobile = mobileController.text;
        poste = postController.text;
        password = passController.text;


        //print(dropdownValue);

        var url = 'http://maulearn.com/phpM/Register.php';
        var response = await http.post(url, body: {
          "name": name,
          "email": email,
          "mobile": mobile,
          "poste": poste,
          "password": password,
          "dropdownValue": dropdownValue,
          "base64Image": base64Image,
        });

        if (response.statusCode == 200) {
          _showDialog();
        }
        else{
          print("Pas de reponse");
        }
      }
      else{
        _showDialog2();
    }

  }


  getAllSpecialite() async {
    final response = await http.get(
        Uri.encodeFull("https://yataapp.000webhostapp.com/AllSpecialite.php")

    );
    if(response.statusCode == 200){
      setState(() {
        var convertDataToJson = json.decode(response.body);
        specialite = convertDataToJson as List;
        //print(data[0]['Email']);

      });
    }
  }




  void choose() async {

    //file = await ImagePicker.pickImage(source: ImageSource.camera);

    file = await ImagePicker.pickImage(source: ImageSource.gallery);

  }



  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Success"),
          content: new Text("Votre compte ça sera active"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Login()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _loadingDialog() {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Container(
            height: 40,
            child: Column(

              children: <Widget>[

                SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator()),

              ],
            )),
        );
      },
    );
  }



  void _showDialog2() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text("Tout les champs sont obligatoire"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool _validateInputs() {
    if (_key.currentState.validate()) {
//    If all data are correct then save data to out variables
      _key.currentState.save();
    } else {
      return true;
    }
    return false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[500],
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            Center(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.blueGrey[500],
                child: Form(
                  key: _key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/images/yata.png'),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        height: 50,
                        child: Text(
                          "Register",
                          style: TextStyle(color: Colors.white, fontSize: 30.0),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),

                      //card for Fullname TextFormField
                      Card(
                        elevation: 6.0,
                        child: TextFormField(
                          controller:fullNameController,
                          validator: (e) {

                            if (e.isEmpty || validateName(fullNameController.text)!=null) {
                              return "Le nom doit avoir plus de 1 caractère";

                            }else{
                              return null;
                            }

                          },

                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 20, right: 15),
                                child: Icon(Icons.person, color: Colors.black),
                              ),
                              contentPadding: EdgeInsets.all(18),
                              labelText: "Nom et Prenom"),
                        ),
                      ),

                      //card for Email TextFormField
                      Card(
                        elevation: 6.0,
                        child: TextFormField(
                            controller:emailController,
                          validator: (e) {
                            if (e.isEmpty || validateEmail(emailController.text)!=null) {
                              return "Entrez une adresse email valide";
                            }
                            return null;
                          },

                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 20, right: 15),
                                child: Icon(Icons.email, color: Colors.black),
                              ),
                              contentPadding: EdgeInsets.all(18),
                              labelText: "Email"),
                        ),
                      ),

                      //card for Mobile TextFormField
                      Card(
                        elevation: 6.0,
                        child: TextFormField(
                          controller:mobileController,
                          validator: (e) {

                            if (e.isEmpty || !regExp.hasMatch(mobileController.text)  || mobileController.text.length!=8) {
                              return "Le numéro doit être composé de 8 chiffres";
                            }
                            return null;
                          },

                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 20, right: 15),
                              child: Icon(Icons.phone, color: Colors.black),
                            ),
                            contentPadding: EdgeInsets.all(18),
                            labelText: "Mobile",
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      //poste
                      Card(
                        elevation: 6.0,
                        child: TextFormField(
                          controller:postController,
                          validator: (e) {

                            if (e.isEmpty || validateName(postController.text)!=null) {
                              return "Le poste doit avoir plus de 1 caractère";

                            }else{
                              return null;
                            }

                          },

                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 20, right: 15),
                                child: Icon(Icons.person, color: Colors.black),
                              ),
                              contentPadding: EdgeInsets.all(18),
                              labelText: "Poste"),
                        ),
                      ),
                      //card for Profission TextFormField
                      Card(

                        elevation: 6.0,
                        child: Container(
                          padding: EdgeInsets.only(left: 28, right: 28, top: 8, bottom: 8),
                          width: MediaQuery.of(context).size.width-32,
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 26,

                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                            underline: Container(
                              height: 2,

                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                            },
                            items: <String>['Médecins généralistes', 'Gynécologues', 'Pédiatres', 'Chirurgie générale', 'Cardiologie']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),

                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      //card for Password TextFormField
                      Card(
                        elevation: 6.0,
                        child: TextFormField(
                          controller:passController,
                          validator: (e) {
                            if (e.isEmpty || validatePassowrd(passController.text)!=null ) {
                              return "Le mot de passe doit être composé de 6 chiffres";
                            }
                            return null;
                          },
                          obscureText: _secureText,
                          onSaved: (e) => password = e,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: showHide,
                                icon: Icon(_secureText
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 20, right: 15),
                                child: Icon(Icons.phonelink_lock,
                                    color: Colors.black),
                              ),
                              contentPadding: EdgeInsets.all(18),
                              labelText: "Mot de passe"),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(12.0),
                      ),
                      Column(


                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RaisedButton(
                                padding: EdgeInsets.only(left: 80, right: 80, top: 20, bottom: 20),

                                onPressed: choose,
                                child: Text('Choose Image'),
                              ),

                            ],
                          ),
                          file == null
                              ? Text('')

                              : Text(''),

                        ],
                      ),

                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            height: 44.0,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Text(
                                  "Register",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                textColor: Colors.white,
                                color: Colors.blue[900],
                                onPressed: () {



                                  if (fullNameController.text.length!=0 && emailController.text.length!=0 && mobileController.text.length!=0 && postController.text.length!=0
                                      &&  passController.text.length!=0 && file!=null){
                                    _loadingDialog();
                                  }
                                  sendInfo();


                                }),
                          ),
                          SizedBox(
                            height: 44.0,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Text(
                                  "Login",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                textColor: Colors.white,
                                color: Colors.blue[900],
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],

        ),
      ),
    );
  }
}

