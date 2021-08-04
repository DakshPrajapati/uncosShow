import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:ui';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:uncos_show/screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('logo'),
        backgroundColor: Color(0xff212832),
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      body: mainScreen(),
    );
  }
}

class mainScreen extends StatefulWidget {
  @override
  _mainScreenState createState() => _mainScreenState();
}

int currentIndex;

class _mainScreenState extends State<mainScreen> {
  Future getdata() async {
    QuerySnapshot qn = await Firestore.instance
        .collection('news')
        .orderBy('name')
        .getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    List<DocumentSnapshot> _list;
    return SafeArea(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 15.0, left: 15, top: 15, bottom: 15),
              child: GradientText(
                'Discover',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                colors: [
                  Colors.white,
                  Colors.blue,
                ],
              ),
            ),
            color: Color(0xff212832),
          ),
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('images/uncosBg.png'),
                fit: BoxFit.cover,
              )),
              child: FutureBuilder(
                future: getdata(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 15.0, left: 15, bottom: 15),
                            child: InkWell(
                              onTap: () {
                                currentIndex = index;
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => secondPage()));
                              },
                              child: ClipRRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 3,
                                    sigmaY: 3,
                                  ),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 30,
                                    //height: 160,
                                    //color: Colors.red,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 0.5,
                                        color: Colors.white.withOpacity(0.2),
                                      ),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.white.withOpacity(0.2),
                                          Colors.white.withOpacity(0.1),
                                        ],
                                        begin: FractionalOffset(0.5, 0),
                                        end: FractionalOffset(0.5, 1),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GradientText(
                                            snapshot.data[index].data["title"],
                                            style: TextStyle(
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            colors: [
                                              Colors.lightBlueAccent,
                                              Colors.blue,
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            snapshot.data[index].data["name"],
                                            style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(.9)),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            snapshot.data[index].data["brief"],
                                            style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(.7)),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              GradientText(
                                                snapshot
                                                    .data[index].data["date"],
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  //fontWeight: FontWeight.bold,
                                                ),
                                                colors: [
                                                  Colors.lightBlueAccent,
                                                  Colors.blue,
                                                ],
                                              ),
                                              GradientText(
                                                snapshot
                                                    .data[index].data["time"],
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  //fontWeight: FontWeight.bold,
                                                ),
                                                colors: [
                                                  Colors.lightBlueAccent,
                                                  Colors.blue,
                                                ],
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color(0xff3D7392),
                                                        Color(0xff4192C0),
                                                      ],
                                                      begin: FractionalOffset(
                                                          0.5, 0),
                                                      end: FractionalOffset(
                                                          0.5, 1),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Icon(
                                                  Icons.chevron_right,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class secondPage extends StatefulWidget {
  @override
  _secondPageState createState() => _secondPageState();
}

class _secondPageState extends State<secondPage> {
  Future getdata2() async {
    QuerySnapshot qn2 = await Firestore.instance
        .collection('news')
        .orderBy('name')
        .getDocuments();
    return qn2.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212832),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 15.0, left: 15, top: 20),
          child: Container(
              child: FutureBuilder(
            future: getdata2(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: Colors.white.withOpacity(0.2),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.2),
                            Colors.white.withOpacity(0.1),
                          ],
                          begin: FractionalOffset(0.5, 0),
                          end: FractionalOffset(0.5, 1),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GradientText(
                            snapshot.data[currentIndex].data["title"],
                            colors: [
                              Colors.lightBlueAccent,
                              Colors.blue,
                            ],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: Colors.white.withOpacity(0.2),
                              ),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.2),
                                  Colors.white.withOpacity(0.1),
                                ],
                                begin: FractionalOffset(0.5, 0),
                                end: FractionalOffset(0.5, 1),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            //color: Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Center(
                                  child: Text(
                                snapshot.data[currentIndex].data["date"],
                                style: TextStyle(color: Colors.blue),
                              )),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: Colors.white.withOpacity(0.2),
                              ),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.2),
                                  Colors.white.withOpacity(0.1),
                                ],
                                begin: FractionalOffset(0.5, 0),
                                end: FractionalOffset(0.5, 1),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Center(
                                  child: Text(
                                snapshot.data[currentIndex].data["time"],
                                style: TextStyle(color: Colors.blue),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      snapshot.data[currentIndex].data["details"],
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          'By: ',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          snapshot.data[currentIndex].data["name"],
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    )
                  ],
                );
              }
            },
          )),
        ),
      ),
    );
  }
}
