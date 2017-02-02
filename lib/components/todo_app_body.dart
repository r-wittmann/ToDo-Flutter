import 'package:ToDo/components/list_elements/parent_element.dart';
import 'package:flutter/material.dart';

class ToDoAppBody extends StatefulWidget {
  List toDoList;

  var toggleDone;
  var leftSwipe;
  var undoLeftSwipe;
  var rightSwipe;
  var undoRightSwipe;


  ToDoAppBody(this.toDoList, this.toggleDone, this.leftSwipe,
      this.undoLeftSwipe, this.rightSwipe, this.undoRightSwipe);

  @override
  State createState() => new ToDoAppBodyState();
}

class ToDoAppBodyState extends State<ToDoAppBody> {
  List _listElements;

  @override
  Widget build(BuildContext context) {
    _listElements = [];

    config.toDoList.forEach((toDo) {
      _listElements.add(new ParentElement(
          toDo,
          config.toggleDone,
          config.leftSwipe,
          config.undoLeftSwipe,
          config.rightSwipe,
          config.undoRightSwipe));
    });

    return new Block(
      children: _listElements,
    );
  }
}
