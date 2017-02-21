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
  List toDoCategories;

  Color color;
  Brightness brightness;
  var changeTheme;
  var changeColor;

  bool displayDone;
  var toggleDisplayDone;

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
      this.toDoCategories,
      this.color,
      this.brightness,
      this.changeTheme,
      this.changeColor,
      this.displayDone,
      this.toggleDisplayDone);

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
          elevation: 2,
          title: _getAppTitle(),
//          actions: [
//            new PopupMenuButton(
//                onSelected: (selected) {},
//                itemBuilder: (BuildContext context) => [
//                  new Padding(
//                    padding: new EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
//                    child: new Text('Filter Categories:'),
//                  ),
//                  new CheckedPopupMenuItem(
//                    value: 0,
//                    checked: true,
//                    child: new Text('Category I', textScaleFactor: 0.9)
//                  ),
//                  new CheckedPopupMenuItem(
//                      value: 0,
//                      checked: false,
//                      child: new Text('Category II', textScaleFactor: 0.9)
//                  ),
//                  new CheckedPopupMenuItem(
//                      value: 0,
//                      checked: true,
//                      child: new Text('Category III', textScaleFactor: 0.9)
//                  ),
//                ],
//            ),
//          ],
        ),
        body: new ToDoAppBody(
            config.indicator,
            config.toDoList,
            config.toggleDone,
            config.leftSwipe,
            config.undoLeftSwipe,
            config.rightSwipe,
            config.undoRightSwipe,
            config.reorderList,
            config.displayDone,
            config.toggleDisplayDone),
        floatingActionButton: config.indicator == 0
            ? new FloatingActionButton(
                mini: true,
                backgroundColor: config.color,
                child: new Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (BuildContext context) {
                      return new ToDoAppCreate(
                          config.createToDo, config.toDoCategories);
                    }),
                  );
                },
              )
            : new Container(),
      );
    }
  }
}
