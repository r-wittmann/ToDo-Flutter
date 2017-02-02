import 'package:flutter/material.dart';

class Archive extends StatefulWidget {
  var toDo;
  var toggleToDo;
  var leftSwipe;
  var undoLeftSwipe;
  var rightSwipe;
  var undoRightSwipe;

  Archive(this.toDo, this.toggleToDo, this.leftSwipe,
      this.undoLeftSwipe, this.rightSwipe, this.undoRightSwipe);

  @override
  State createState() => new ArchiveState();
}

class ArchiveState extends State<Archive> {
  void _leftSwipe() {
    config.leftSwipe(config.toDo, false);
    Scaffold.of(context).showSnackBar(
          new SnackBar(
            backgroundColor: Colors.grey[400],
            duration: new Duration(seconds: 2),
            content: new Text('ToDo restored'),
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
            content: new Text('ToDo deleted'),
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
      direction: DismissDirection.horizontal,
      resizeDuration: new Duration(milliseconds: 500),
      background: new Container(
        decoration: new BoxDecoration(backgroundColor: Colors.red[400]),
        child: new ListItem(
          leading: new Icon(Icons.delete, size: 40.0),
        ),
      ),
      secondaryBackground: new Container(
        decoration: new BoxDecoration(backgroundColor: Colors.green[500]),
        child: new ListItem(
          trailing: new Icon(Icons.unarchive, size: 40.0),
        ),
      ),
      child: new ListItem(
        dense: true,
        leading: new IconButton(
            icon: new Icon(config.toDo['done']
                ? Icons.check_box
                : Icons.check_box_outline_blank),
            onPressed: () {}
        ),
        title: new Text(config.toDo['title']),
        subtitle: new Text(config.toDo['subtitle']),
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
