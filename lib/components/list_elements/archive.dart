import 'package:flutter/material.dart';

class Archive extends StatefulWidget {
  var toDo;
  var leftSwipe;
  var undoLeftSwipe;
  var rightSwipe;
  var undoRightSwipe;

  Archive(this.toDo, this.leftSwipe, this.undoLeftSwipe,
      this.rightSwipe, this.undoRightSwipe);

  @override
  State createState() => new ArchiveState();
}

class ArchiveState extends State<Archive> {
  void _unarchiveItem() {
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
          trailing: new Icon(Icons.unarchive),
        ),
      ),
      child: new ListItem(
        dense: true,
        enabled: false,
        title: new Text(config.toDo['title']),
        subtitle: new Text(config.toDo['subtitle']),
        onTap: () {},
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd)
          print('delete');
        // _deleteItem();
        else
          _unarchiveItem();
      },
    );
  }
}
