import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'dart:math';
import 'dart:async';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'words.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: CategoriesPage(),
      ),
    );
  }
}

class CategoriesPage extends StatefulWidget {
  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  var d = sqrt(window.physicalSize.height * window.physicalSize.height +
      window.physicalSize.width * window.physicalSize.width);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: ,),
      backgroundColor: Colors.red,
      body: GridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        children: [
          FlatButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CharadesPage(liste: hp)),
              );
            },
            child: Text(
              'Harry Potter',
              style: TextStyle(fontSize: d / 36),
            ),
          ),
          FlatButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CharadesPage(liste: nct)),
              );
            },
            child: Text(
              'NCT',
              style: TextStyle(fontSize: d / 36),
            ),
          ),
          FlatButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CharadesPage(liste: hpsorts)),
              );
            },
            child: Text(
              'Harry Potter (sorts)',
              style: TextStyle(fontSize: d / 36),
              textAlign: TextAlign.center,
            ),
          ),
          FlatButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CharadesPage(liste: vd)),
              );
            },
            child: Text(
              'Vampire Diaries',
              style: TextStyle(fontSize: d / 36),
              textAlign: TextAlign.center,
            ),
          ),
          FlatButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CharadesPage(liste: capitales)),
              );
            },
            child: Text(
              'Capitales',
              style: TextStyle(fontSize: d / 36),
            ),
          ),
          FlatButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CharadesPage(liste: countries)),
              );
            },
            child: Text(
              'Pays',
              style: TextStyle(fontSize: d / 36),
            ),
          ),
          FlatButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CharadesPage(liste: disneyHV)),
              );
            },
            child: Text(
              'Disney (Heroes & Villains)',
              style: TextStyle(
                fontSize: d / 36,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          FlatButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CharadesPage(liste: disneyMovies)),
              );
            },
            child: Text(
              'Disney (Movies)',
              style: TextStyle(
                fontSize: d / 36,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class CharadesPage extends StatefulWidget {
  final List<String> liste;

  CharadesPage({Key key, @required this.liste}) : super(key: key);

  State<CharadesPage> createState() => _CharadesPageState(list: liste);
}

class _CharadesPageState extends State<CharadesPage> {
  var d = sqrt(window.physicalSize.height * window.physicalSize.height +
      window.physicalSize.width * window.physicalSize.width);
  final List<String> list;

  _CharadesPageState({@required this.list});

  var colour = Colors.blue;
  var score = 0;
  var word = "Press X to begin";
  var counter = 5;
  var timer = Timer(Duration(seconds: 0), null);
  List<Widget> words = [];

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (counter > 0) {
          counter--;
        } else {
          timer.cancel();
          Alert(
            title: '',
            context: context,
            style: AlertStyle(
              animationType: AnimationType.grow,
              animationDuration: Duration(seconds: 1),
              isCloseButton: false,
              isOverlayTapDismiss: false,
              backgroundColor: Colors.blue,
            ),
            buttons: [
              DialogButton(
                  height: d / 24,
                  width: d / 3,
                  child: Text(
                    'Retry',
                    style: TextStyle(fontSize: d / 36),
                  ),
                  color: colour,
                  onPressed: () {
                    setState(() {
                      score = 0;
                      counter = 5;
                      words = [];
                      word = "Press X to begin";
                      Navigator.pop(context);
                    });
                  })
            ],
            content: Container(
              height: d / 3,
              width: d / 2,
              child: ListView(children: words),
            ),
          ).show();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              child: Column(
                children: [
                  Expanded(
                    child: Icon(
                      Icons.check,
                      color: Colors.black,
                      size: d / 10,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                setState(() {
                  colour = Colors.green;
                  if (timer.isActive) {
                    word = list[Random().nextInt(list.length)];
                    score++;
                    words.add(ListTile(
                        title: Text(
                          word,
                          style:
                              TextStyle(fontSize: d / 24, color: Colors.green),
                        ),
                        leading: Icon(
                          Icons.check,
                          size: d / 24,
                          color: Colors.black,
                        )));
                  }
                });
              },
              color: colour,
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: Column(
                children: [
                  Text('$counter', style: TextStyle(fontSize: d / 24)),
                  Expanded(
                      child: Center(
                    child: Text(
                      word,
                      style: TextStyle(fontSize: d / 12),
                      textAlign: TextAlign.center,
                    ),
                  )),
                  Text('$score', style: TextStyle(fontSize: d / 24)),
                ],
              ),
            ),
          ),
          Expanded(
            child: FlatButton(
              color: colour,
              child: Column(
                children: [
                  Expanded(
                    child: Icon(
                      Icons.clear,
                      color: Colors.black,
                      size: d / 10,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                setState(() {
                  colour = Colors.red;
                  if (timer.isActive) {
                    word = list[Random().nextInt(list.length)];
                    words.add(ListTile(
                        title: Text(
                          word,
                          style: TextStyle(fontSize: d / 24, color: Colors.red),
                        ),
                        leading: Icon(Icons.clear,
                            size: d / 24, color: Colors.black)));
                  } else if (counter == 5) {
                    startTimer();
                    score = 0;
                    word = list[Random().nextInt(list.length)];
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
