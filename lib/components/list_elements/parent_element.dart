import 'package:flutter/material.dart';
import 'todo.dart';
import 'done.dart';
import 'archive.dart';

class ParentElement extends StatefulWidget {
  int indicator;
  var toDo;
  var toggleToDo;
  var leftSwipe;
  var undoLeftSwipe;
  var rightSwipe;
  var undoRightSwipe;

  ParentElement(this.indicator, this.toDo, this.toggleToDo, this.leftSwipe,
      this.undoLeftSwipe, this.rightSwipe, this.undoRightSwipe);

  @override
  State createState() => new ParentElementState();
}

class ParentElementState extends State<ParentElement> {
  @override
  Widget build(BuildContext context) {
    switch (config.indicator) {
      case 0:
        return new ToDo(config.toDo, config.toggleToDo, config.leftSwipe,
            config.undoLeftSwipe, config.rightSwipe, config.undoRightSwipe);
        break;
      case 1:
        return new Done(config.toDo, config.toggleToDo, config.leftSwipe,
            config.undoLeftSwipe, config.rightSwipe, config.undoRightSwipe);
        break;
      default:
        return new Archive(config.toDo, config.leftSwipe, config.undoLeftSwipe,
            config.rightSwipe, config.undoRightSwipe);
        break;
    }
  }
}
