import 'package:ToDo/components/list_elements/archive.dart';
import 'package:ToDo/components/list_elements/trash.dart';
import 'package:flutter/material.dart';
import 'todo.dart';

class ParentElement extends StatefulWidget {
  int indicator;
  var toDo;
  var toggleToDo;
  var leftSwipe;
  var undoLeftSwipe;
  var rightSwipe;
  var undoRightSwipe;

  var reorderList;

  ParentElement(
      this.indicator,
      this.toDo,
      this.toggleToDo,
      this.leftSwipe,
      this.undoLeftSwipe,
      this.rightSwipe,
      this.undoRightSwipe,
      this.reorderList);

  @override
  State createState() => new ParentElementState();
}

class ParentElementState extends State<ParentElement> {
  @override
  Widget build(BuildContext context) {
    switch (config.indicator) {
      case 0:
        return new ToDo(
            config.toDo,
            config.toggleToDo,
            config.leftSwipe,
            config.undoLeftSwipe,
            config.rightSwipe,
            config.undoRightSwipe,
            config.reorderList);
        break;
      case 1:
        return new Archive(config.toDo, config.toggleToDo, config.leftSwipe,
            config.undoLeftSwipe, config.rightSwipe, config.undoRightSwipe);
        break;
      default:
        return new Trash(config.toDo, config.toggleToDo, config.leftSwipe,
            config.undoLeftSwipe, config.rightSwipe, config.undoRightSwipe);
        break;
    }
  }
}
