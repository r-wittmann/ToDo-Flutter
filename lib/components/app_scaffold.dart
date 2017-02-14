import 'dart:async';
import 'package:ToDo/components/app_body.dart';
import 'package:ToDo/components/app_create.dart';
import 'package:ToDo/components/app_drawer.dart';
import 'package:ToDo/components/app_splash.dart';
import 'package:flutter/material.dart';

class ToDoAppScaffold extends StatefulWidget {
  int indicator;
  bool toDosLoaded;
  List toDoList;

  var toggleDone;
  var leftSwipe;
  var undoLeftSwipe;
  var rightSwipe;
  var undoRightSwipe;

  var createToDo;
  var emptyTrash;

  var reorderList;

  Color color;
  Brightness brightness;
  var changeTheme;
  var changeColor;

  ToDoAppScaffold(
      this.indicator,
      this.toDosLoaded,
      this.toDoList,
      this.toggleDone,
      this.leftSwipe,
      this.undoLeftSwipe,
      this.rightSwipe,
      this.undoRightSwipe,
      this.createToDo,
      this.emptyTrash,
      this.reorderList,
      this.color,
      this.brightness,
      this.changeTheme,
      this.changeColor);

  @override
  State createState() => new ToDoAppScaffoldState(this.toDosLoaded);
}

class ToDoAppScaffoldState extends State<ToDoAppScaffold> {
  bool _displaySplash;

  ToDoAppScaffoldState(bool toDosLoaded) {
    _displaySplash = !toDosLoaded;
  }

  void _removeSplash() {
    new Timer(const Duration(milliseconds: 4000), () {
      setState(() {
        _displaySplash = false;
      });
    });
  }

  Widget _getAppTitle() {
    String title;
    switch (config.indicator) {
      case 0:
        title = 'ToDo List';
        break;
      case 1:
        title = 'Archive';
        break;
      default:
        title = 'Trash';
        break;
    }
    return new Text(title);
  }

  @override
  Widget build(BuildContext context) {
    if (_displaySplash) {
      _removeSplash();
      return new ToDoSplash();
    } else {
      return new Scaffold(
          drawer: new ToDoAppDrawer(
              config.indicator,
              config.color,
              config.brightness,
              config.changeTheme,
              config.changeColor,
              config.emptyTrash),
          appBar: new AppBar(
            iconTheme: new IconThemeData(
              color: config.color == Colors.grey[100]
                  ? Colors.grey[850]
                  : Colors.grey[100],
            ),
            textTheme: new TextTheme(
                title: new TextStyle(
              color: config.color == Colors.grey[100]
                  ? Colors.grey[850]
                  : Colors.grey[100],
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            )),
            elevation: 2,
            leading: new Builder(
              builder: (context) {
                return new IconButton(
                    icon: new Icon(Icons.more_vert),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    });
              },
            ),
            title: _getAppTitle(),
            actions: [
              config.indicator == 0
                  ? new IconButton(
                      icon: new Icon(Icons.playlist_add),
                      onPressed: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) {
                            return new ToDoAppCreate(config.createToDo);
                          }),
                        );
                      })
                  : new Container(),
            ],
          ),
          body: new ToDoAppBody(
              config.indicator,
              config.toDoList,
              config.toggleDone,
              config.leftSwipe,
              config.undoLeftSwipe,
              config.rightSwipe,
              config.undoRightSwipe,
              config.reorderList));
    }
  }
}
