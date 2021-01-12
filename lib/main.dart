import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'dart:math';
import 'dart:async';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'lists.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
  var counter = 120;
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var d = sqrt(MediaQuery.of(context).size.height *
            MediaQuery.of(context).size.height +
        MediaQuery.of(context).size.width * MediaQuery.of(context).size.width);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.timer, size: d / 24, color: Colors.black),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        leadingWidth: d / 20,
        title: Center(
          child: Text(
            'Charades',
            style: TextStyle(fontSize: d / 20, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        toolbarHeight: d / 18,
      ),
      drawer: Container(
        color: Colors.red,
        width: d / 4,
        child: GridView.count(
          crossAxisCount: 1,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 4,
          children: <Widget>[
            DrawerHeader(
              child: ListTile(
                title: Text(
                  'Timer',
                  style: TextStyle(fontSize: d / 24),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: RadioListTile(
                  activeColor: Colors.red,
                  title:
                      Text('120 Secondes', style: TextStyle(fontSize: d / 36)),
                  value: 120,
                  groupValue: counter,
                  onChanged: (value) {
                    setState(() {
                      counter = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: RadioListTile(
                  activeColor: Colors.red,
                  title:
                      Text('60 Secondes', style: TextStyle(fontSize: d / 36)),
                  value: 60,
                  groupValue: counter,
                  onChanged: (value) {
                    setState(() {
                      counter = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: RadioListTile(
                  activeColor: Colors.red,
                  title:
                      Text('30 Secondes', style: TextStyle(fontSize: d / 36)),
                  value: 30,
                  groupValue: counter,
                  onChanged: (value) {
                    setState(() {
                      counter = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.red,
      body: OrientationBuilder(builder: (context, orientation) {
        return GridView.builder(
          padding: EdgeInsets.all(20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                orientation == Orientation.portrait ? 2 : 4,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          itemCount: lilist.length,
          itemBuilder: (BuildContext context, int index) {
            return new FlatButton(
              color: Colors.blue,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CharadesPage(
                          liste: lilist[index], counter: counter, d: d)),
                );
              },
              child: Text(
                liliste[index],
                style: TextStyle(fontSize: d / 36),
                textAlign: TextAlign.center,
              ),
            );
          },
        );
      }),
    );
  }
}

class CharadesPage extends StatefulWidget {
  final List<String> liste;
  final int counter;
  final double d;

  CharadesPage(
      {Key key, @required this.liste, @required this.counter, @required this.d})
      : super(key: key);

  State<CharadesPage> createState() =>
      _CharadesPageState(list: liste, c: counter, counter: counter, d: d);
}

class _CharadesPageState extends State<CharadesPage> {
  final List<String> list;
  int c;
  int counter;
  double d;

  _CharadesPageState(
      {@required this.list,
      @required this.c,
      @required this.counter,
      @required this.d});

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
            title: 'Score : $score',
            context: context,
            style: AlertStyle(
                animationType: AnimationType.grow,
                animationDuration: Duration(seconds: 1),
                isCloseButton: false,
                isOverlayTapDismiss: false,
                backgroundColor: Colors.blue,
                titleStyle: TextStyle(fontSize: d / 24)),
            buttons: [
              DialogButton(
                  height: d / 24,
                  width: d / 4,
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
                  }),
              DialogButton(
                height: d / 24,
                width: d / 4,
                child: Text(
                  'Home',
                  style: TextStyle(fontSize: d / 36),
                ),
                color: colour,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              )
            ],
            content: Container(
              height: d / 4,
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.undo, size: d / 36, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        leadingWidth: d / 32,
        shadowColor: colour,
        title: Center(
            child: Text('$counter',
                style: TextStyle(fontSize: d / 24, color: Colors.black),
                textAlign: TextAlign.center)),
        backgroundColor: colour,
        elevation: 1,
        toolbarHeight: d / 20,
      ),
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
                    score++;
                    words.add(ListTile(
                        title: Text(
                          word,
                          style:
                              TextStyle(fontSize: d / 24, color: Colors.green),
                        ),
                        leading: Icon(Icons.check,
                            size: d / 24, color: Colors.black)));
                    word = list[Random().nextInt(list.length)] +
                        (list == ptitbac
                            ? '\nen ' +
                                alphabet[Random().nextInt(alphabet.length)]
                            : '');
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
                  Expanded(
                      child: Center(
                    child: Text(
                      word,
                      style: TextStyle(fontSize: d / 16),
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
                    words.add(ListTile(
                        title: Text(
                          word,
                          style: TextStyle(fontSize: d / 24, color: Colors.red),
                        ),
                        leading: Icon(Icons.clear,
                            size: d / 24, color: Colors.black)));
                    word = list[Random().nextInt(list.length)] +
                        (list == ptitbac
                            ? '\nen ' +
                                alphabet[Random().nextInt(alphabet.length)]
                            : '');
                  } else if (counter == c) {
                    startTimer();
                    score = 0;
                    word = list[Random().nextInt(list.length)] +
                        (list == ptitbac
                            ? '\nen ' +
                                alphabet[Random().nextInt(alphabet.length)]
                            : '');
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
