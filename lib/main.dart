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
  var counter = 120;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Charades',
            style: TextStyle(fontSize: d / 20, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        toolbarHeight: d / 20,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: ListTile(
                title: Text('Timer', style: TextStyle(fontSize: d / 36)),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.red,
      body: GridView.count(
        padding: EdgeInsets.all(20),
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
                    builder: (context) =>
                        CharadesPage(liste: hp, counter: counter)),
              );
            },
            child: Text(
              'Harry Potter',
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
                    builder: (context) =>
                        CharadesPage(liste: nct, counter: counter)),
              );
            },
            child: Text(
              'NCT',
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
                    builder: (context) =>
                        CharadesPage(liste: hpsorts, counter: counter)),
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
                    builder: (context) =>
                        CharadesPage(liste: vd, counter: counter)),
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
                    builder: (context) =>
                        CharadesPage(liste: capitales, counter: counter)),
              );
            },
            child: Text(
              'Capitales',
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
                    builder: (context) =>
                        CharadesPage(liste: countries, counter: counter)),
              );
            },
            child: Text(
              'Pays',
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
                    builder: (context) =>
                        CharadesPage(liste: disneyHV, counter: counter)),
              );
            },
            child: Text(
              'Disney (Heroes & Villains)',
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
                    builder: (context) =>
                        CharadesPage(liste: disneyMovies, counter: counter)),
              );
            },
            child: Text(
              'Disney (Films)',
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
                    builder: (context) =>
                        CharadesPage(liste: hercule, counter: counter)),
              );
            },
            child: Text(
              'Hercule (Mythologie)',
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
                    builder: (context) =>
                        CharadesPage(liste: aristochats, counter: counter)),
              );
            },
            child: Text(
              'Les Aristochats',
              style: TextStyle(fontSize: d / 36),
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
  final int counter;

  CharadesPage({Key key, @required this.liste, @required this.counter})
      : super(key: key);

  State<CharadesPage> createState() =>
      _CharadesPageState(list: liste, c: counter, counter: counter);
}

class _CharadesPageState extends State<CharadesPage> {
  var d = sqrt(window.physicalSize.height * window.physicalSize.height +
      window.physicalSize.width * window.physicalSize.width);
  final List<String> list;
  int c;
  int counter;

  _CharadesPageState(
      {@required this.list, @required this.c, @required this.counter});

  var colour = Colors.blue;
  var score = 0;
  var word = "Press X to begin";
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
                      counter = c;
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
                  } else if (counter == c) {
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
