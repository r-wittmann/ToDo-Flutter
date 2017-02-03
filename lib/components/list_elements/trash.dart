import 'package:flutter/material.dart';

class Trash extends StatefulWidget {
  var toDo;
  var toggleToDo;
  var leftSwipe;
  var undoLeftSwipe;
  var rightSwipe;
  var undoRightSwipe;

  Trash(this.toDo, this.toggleToDo, this.leftSwipe, this.undoLeftSwipe,
      this.rightSwipe, this.undoRightSwipe);

  @override
  State createState() => new TrashState();
}

class TrashState extends State<Trash> {
  void _rightSwipe() {
    config.rightSwipe(config.toDo, false);
    Scaffold.of(context).showSnackBar(
          new SnackBar(
            backgroundColor: Colors.grey[400],
            duration: new Duration(seconds: 2),
            content: new Text('ToDo restored'),
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
      direction: DismissDirection.startToEnd,
      resizeDuration: new Duration(milliseconds: 500),
      background: new Container(
        decoration: new BoxDecoration(backgroundColor: Colors.green[400]),
        child: new ListItem(
          leading: new Icon(Icons.restore_from_trash, size: 40.0),
        ),
      ),
      child: new ListItem(
        dense: true,
        enabled: false,
        leading: new IconButton(
            icon: new Icon(config.toDo['done']
                ? Icons.check_box
                : Icons.check_box_outline_blank),
            onPressed: () {}),
        title: new Text(config.toDo['title']),
        subtitle: new Text(config.toDo['subtitle']),
        onTap: () {},
      ),
      onDismissed: (direction) {
        _rightSwipe();
      },
    );
  }
}
