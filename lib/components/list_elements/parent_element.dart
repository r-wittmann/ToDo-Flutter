import 'package:flutter/material.dart';
import 'todo.dart';

class ParentElement extends StatefulWidget {
  var toDo;
  var toggleToDo;
  var leftSwipe;
  var undoLeftSwipe;
  var rightSwipe;
  var undoRightSwipe;

  ParentElement(this.toDo, this.toggleToDo, this.leftSwipe, this.undoLeftSwipe,
      this.rightSwipe, this.undoRightSwipe);

  @override
  State createState() => new ParentElementState();
}

class ParentElementState extends State<ParentElement> {
  @override
  Widget build(BuildContext context) {
    return new ToDo(config.toDo, config.toggleToDo, config.leftSwipe,
        config.undoLeftSwipe, config.rightSwipe, config.undoRightSwipe);
  }
}
