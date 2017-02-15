import 'package:ToDo/components/app_todo.dart';
import 'package:flutter/material.dart';

class ToDoAppBody extends StatefulWidget {
  int indicator;
  List toDoList;

  var toggleDone;
  var leftSwipe;
  var undoLeftSwipe;
  var rightSwipe;
  var undoRightSwipe;

  var reorderList;

  ToDoAppBody(
      this.indicator,
      this.toDoList,
      this.toggleDone,
      this.leftSwipe,
      this.undoLeftSwipe,
      this.rightSwipe,
      this.undoRightSwipe,
      this.reorderList);

  @override
  State createState() => new ToDoAppBodyState();
}

class ToDoAppBodyState extends State<ToDoAppBody> {
  List _listElements;
  var _expandedElement = null;

  void _toggleExpand(toDo, bool expand) {
      setState(() {
        _expandedElement = expand ? toDo : null;
      });
  }

  @override
  Widget build(BuildContext context) {
    _listElements = [];

    config.toDoList.forEach((toDo) {
      if (toDo['done'] && toDo == config.toDoList.firstWhere((a) => a['done']))
        _listElements.add(
          new Row(
            children: [
              new Padding(
                padding: new EdgeInsets.symmetric(horizontal: 8.0),
                child: new Text('Already done:'),
              ),
              new Expanded(
                child: new Container(
                  height: 1.0,
                  margin: new EdgeInsets.only(right: 8.0),
                  decoration: new BoxDecoration(
                    backgroundColor: Theme.of(context).dividerColor,
                  ),
                ),
              ),
            ],
          ),
        );
      _listElements.add(new ToDo(
          config.indicator,
          toDo,
          _expandedElement == toDo,
          _toggleExpand,
          config.toggleDone,
          config.leftSwipe,
          config.undoLeftSwipe,
          config.rightSwipe,
          config.undoRightSwipe,
          config.reorderList));
    });

    return new ListView(
      children: _listElements,
    );
  }
}
