import 'package:flutter/material.dart';

class ToDo extends StatefulWidget {
  var toDo;
  var toggleToDo;
  var leftSwipe;
  var undoLeftSwipe;
  var rightSwipe;
  var undoRightSwipe;

  ToDo(this.toDo, this.toggleToDo, this.leftSwipe, this.undoLeftSwipe,
      this.rightSwipe, this.undoRightSwipe);

  @override
  State createState() => new ToDoState();
}

class ToDoState extends State<ToDo> {
  DismissDirection _dismissDirection = DismissDirection.horizontal;

  @override
  void initState() {
    super.initState();
    if (config.leftSwipe is Function && config.rightSwipe is! Function)
      _dismissDirection = DismissDirection.endToStart;
    else if(config.leftSwipe is! Function && config.rightSwipe is Function)
      _dismissDirection = DismissDirection.startToEnd;
    else
      _dismissDirection = DismissDirection.horizontal;
  }

  void _leftSwipe() {
    config.leftSwipe(config.toDo, false);
    Scaffold.of(context).showSnackBar(
          new SnackBar(
            backgroundColor: Colors.grey[400],
            duration: new Duration(seconds: 2),
            content: new Text(''),
            action: new SnackBarAction(
              label: 'UNDO',
              onPressed: () {
                config.undoLeftSwipe(config.toDo, true);
              },
            ),
          ),
        );
  }
  void _rightSwipe() {
    config.rightSwipe(config.toDo, false);
    Scaffold.of(context).showSnackBar(
      new SnackBar(
        backgroundColor: Colors.grey[400],
        duration: new Duration(seconds: 2),
        content: new Text(''),
        action: new SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            config.undoRightSwipe(config.toDo, true);
          },
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return new Dismissable(
      key: new ObjectKey({'toDo': config.toDo}),
      direction: _dismissDirection,
      resizeDuration: new Duration(milliseconds: 500),
      background: new Container(
        decoration: new BoxDecoration(backgroundColor: Colors.red[400]),
        child: new ListItem(
          leading: new Icon(Icons.delete),
        ),
      ),
      secondaryBackground: new Container(
        decoration: new BoxDecoration(backgroundColor: Colors.blue[500]),
        child: new ListItem(
          trailing: new Icon(Icons.archive),
        ),
      ),
      child: new ListItem(
        dense: true,
        title: new Text(config.toDo['title']),
        subtitle: new Text(config.toDo['subtitle']),
        onTap: () {
          config.toggleToDo(config.toDo);
        },
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd)
          _rightSwipe();
        else
          _leftSwipe();
      },
    );
  }
}
