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

  bool displayDone;
  var toggleDisplayDone;

  ToDoAppBody(
      this.indicator,
      this.toDoList,
      this.toggleDone,
      this.leftSwipe,
      this.undoLeftSwipe,
      this.rightSwipe,
      this.undoRightSwipe,
      this.reorderList,
      this.displayDone,
      this.toggleDisplayDone);

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

    widget.toDoList.forEach((toDo) {
      if (toDo['done'] &&
          toDo == widget.toDoList.firstWhere((a) => a['done']) &&
          widget.indicator == 0) {
        _listElements.add(
          new AnimatedCrossFade(
            firstChild: new FlatButton(
              child: new Text('Hide done ToDos', textScaleFactor: 0.9),
              onPressed: () {
                widget.toggleDisplayDone();
              },
            ),
            firstCurve: new Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
            secondChild: new FlatButton(
              child: new Text('Show done ToDos', textScaleFactor: 0.9),
              onPressed: () {
                widget.toggleDisplayDone();
              },
            ),
            secondCurve: new Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
            duration: const Duration(milliseconds: 300),
            crossFadeState: widget.displayDone
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
          ),
        );
      }
      if (!toDo['done'] || widget.displayDone) {
        _listElements.add(new ToDo(
            widget.indicator,
            toDo,
            _expandedElement == toDo,
            _toggleExpand,
            widget.toggleDone,
            widget.leftSwipe,
            widget.undoLeftSwipe,
            widget.rightSwipe,
            widget.undoRightSwipe,
            widget.reorderList));
      }
    });

    return new ListView(
      children: _listElements,
    );
  }
}
