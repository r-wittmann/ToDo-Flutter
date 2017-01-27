import 'package:flutter/material.dart';

class Done extends StatefulWidget {
  var toDo;
  var toggleToDo;
  var leftSwipe;
  var undoLeftSwipe;
  var rightSwipe;
  var undoRightSwipe;

  Done(this.toDo, this.toggleToDo, this.leftSwipe, this.undoLeftSwipe,
      this.rightSwipe, this.undoRightSwipe);

  @override
  State createState() => new DoneState();
}

class DoneState extends State<Done> {
  void _archiveItem() {
    config.leftSwipe(config.toDo, false);
    Scaffold.of(context).showSnackBar(
      new SnackBar(
        backgroundColor: Colors.grey[800],
        duration: new Duration(seconds: 2),
        content: new Text('Unarchived ToDo'),
        action: new SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            config.undoLeftSwipe(config.toDo, true);
          },
        ),
      ),
    );
  }

  void _deleteItem() {}
  @override
  Widget build(BuildContext context) {
    return new Dismissable(
      key: new ObjectKey({'toDo': config.toDo, 'id': config.toDo['id']}),
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
          print('delete');
        // _deleteItem();
        else
          _archiveItem();
      },
    );
  }
}
