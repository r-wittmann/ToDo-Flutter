import 'package:ToDo/components/list_elements/parent_element.dart';
import 'package:flutter/material.dart';

class ToDoAppBody extends StatefulWidget {
  List toDoList;
  int indicator;

  var toggleToDo;
  var leftSwipe;
  var undoLeftSwipe;
  var rightSwipe;
  var undoRightSwipe;

  ToDoAppBody.todo(this.toDoList, this.toggleToDo, this.leftSwipe,
      this.undoLeftSwipe, this.rightSwipe, this.undoRightSwipe) {
    this.indicator = 0;
  }
  ToDoAppBody.done(this.toDoList, this.toggleToDo, this.leftSwipe,
      this.undoLeftSwipe, this.rightSwipe, this.undoRightSwipe) {
    this.indicator = 1;
  }
  ToDoAppBody.archive(this.toDoList, this.toggleToDo, this.leftSwipe,
      this.undoLeftSwipe, this.rightSwipe, this.undoRightSwipe) {
    this.indicator = 2;
  }

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
          config.indicator,
          toDo,
          config.toggleToDo,
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
