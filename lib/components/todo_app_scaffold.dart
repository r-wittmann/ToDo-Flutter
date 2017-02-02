import 'package:ToDo/components/todo_app_body.dart';
import 'package:ToDo/components/todo_app_create.dart';
import 'package:ToDo/components/todo_app_drawer.dart';
import 'package:flutter/material.dart';

class ToDoAppScaffold extends StatefulWidget {
  String appBarTitle;
  List toDoList;

  var toggleDone;
  var leftSwipe;
  var undoLeftSwipe;
  var rightSwipe;
  var undoRightSwipe;

  Color color;
  Brightness brightness;
  var changeTheme;
  var changeColor;

  ToDoAppScaffold(
      this.appBarTitle,
      this.toDoList,
      this.toggleDone,
      this.leftSwipe,
      this.undoLeftSwipe,
      this.rightSwipe,
      this.undoRightSwipe,
      this.color,
      this.brightness,
      this.changeTheme,
      this.changeColor);

  @override
  State createState() => new ToDoAppScaffoldState();
}

class ToDoAppScaffoldState extends State<ToDoAppScaffold> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new ToDoAppDrawer(config.color, config.brightness,
          config.changeTheme, config.changeColor),
      appBar: new AppBar(
        elevation: 2,
        title: new Text(config.appBarTitle),
        actions: [
          new IconButton(
              icon: new Icon(Icons.create),
              onPressed: () {
//                Navigator.push(
//                  context,
//                  new MaterialPageRoute(builder: (BuildContext context) {
//                    return new ToDoAppCreate(config.updateToDo);
//                  }),
//                );
              }),
        ],
      ),
      body: new ToDoAppBody(
              config.toDoList,
              config.toggleDone,
              config.leftSwipe,
              config.undoLeftSwipe,
              config.rightSwipe,
              config.undoRightSwipe)
    );
  }
}
