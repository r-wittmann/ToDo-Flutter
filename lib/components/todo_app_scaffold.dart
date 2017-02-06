import 'package:ToDo/components/todo_app_body.dart';
import 'package:ToDo/components/todo_app_create.dart';
import 'package:ToDo/components/todo_app_drawer.dart';
import 'package:flutter/material.dart';

class ToDoAppScaffold extends StatefulWidget {
  int indicator;
  List toDoList;

  var toggleDone;
  var leftSwipe;
  var undoLeftSwipe;
  var rightSwipe;
  var undoRightSwipe;

  var createToDo;
  var emptyTrash;

  Color color;
  Brightness brightness;
  var changeTheme;
  var changeColor;

  ToDoAppScaffold(
      this.indicator,
      this.toDoList,
      this.toggleDone,
      this.leftSwipe,
      this.undoLeftSwipe,
      this.rightSwipe,
      this.undoRightSwipe,
      this.createToDo,
      this.emptyTrash,
      this.color,
      this.brightness,
      this.changeTheme,
      this.changeColor);

  @override
  State createState() => new ToDoAppScaffoldState();
}

class ToDoAppScaffoldState extends State<ToDoAppScaffold> {
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
          actions: [
            config.indicator == 0
                ? new IconButton(
                    icon: new Icon(Icons.create),
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(builder: (BuildContext context) {
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
            config.undoRightSwipe));
  }
}
