import 'package:ToDo/components/todo_app_body.dart';
import 'package:ToDo/components/todo_app_create.dart';
import 'package:ToDo/components/todo_app_drawer.dart';
import 'package:flutter/material.dart';

class ToDoAppScaffold extends StatefulWidget {
  List toDoList;
  List doneList;
  List archiveList;
  var doToDo;
  var undoDone;
  var archiveToDo;
  var unarchiveToDo;
  var archiveDone;
  var unarchiveDone;
  var deleteToDo;
  var undeleteToDo;
  var deleteDone;
  var undeleteDone;
  var deleteArchive;
  var undeleteArchive;

  Color color;
  Brightness brightness;
  var changeTheme;
  var changeColor;


  ToDoAppScaffold(this.toDoList, this.doneList, this.archiveList, this.doToDo,
      this.undoDone, this.archiveToDo, this.unarchiveToDo, this.archiveDone,
      this.unarchiveDone, this.deleteToDo, this.undeleteToDo, this.deleteDone,
      this.undeleteDone, this.deleteArchive, this.undeleteArchive, this.color,
      this.brightness, this.changeTheme, this.changeColor);

  @override
  State createState() => new ToDoAppScaffoldState();
}

class ToDoAppScaffoldState extends State<ToDoAppScaffold> {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 3,
      child: new Scaffold(
        drawer: new ToDoAppDrawer(config.color, config.brightness,
            config.changeTheme, config.changeColor),
        appBar: new AppBar(
          elevation: 2,
          title: new Text('ToDo List'),
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
          bottom: new TabBar(
            tabs: [
              new Tab(
                  icon: new Icon(Icons.check_box_outline_blank,
                      color: Colors.white)),
              new Tab(icon: new Icon(Icons.check_box, color: Colors.white)),
              new Tab(icon: new Icon(Icons.archive, color: Colors.white)),
            ],
          ),
        ),
        body: new TabBarView(
          children: [
            new ToDoAppBody.todo(config.toDoList, config.doToDo, config.archiveToDo, config.unarchiveToDo, config.deleteToDo, config.undeleteToDo),
            new ToDoAppBody.done(config.doneList, config.undoDone, config.archiveDone, config.unarchiveDone, config.deleteDone, config.undeleteDone),
            new ToDoAppBody.archive(config.archiveList, null, config.unarchiveToDo, config.archiveToDo, config.deleteArchive, config.undeleteArchive),

          ],
        ),
      )
    );
  }
}

List toDoList;

var doToDo;
var undoDone;
var leftSwipe;
var undoLeftSwipe;
var rightSwipe;
var undoRightSwipe;
