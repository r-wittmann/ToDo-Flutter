import 'package:flutter/material.dart';

class Archive extends StatefulWidget {
  var toDo;
  var toggleToDo;
  var leftSwipe;
  var undoLeftSwipe;
  var rightSwipe;
  var undoRightSwipe;

  Archive(this.toDo, this.toggleToDo, this.leftSwipe, this.undoLeftSwipe,
      this.rightSwipe, this.undoRightSwipe);

  @override
  State createState() => new ArchiveState();
}

class ArchiveState extends State<Archive> {
  ThemeData _theme;
  void _onDragStart() {
    Scaffold.of(context).showBottomSheet((context) {
      return new Container(
        decoration: new BoxDecoration(
            border:
                new Border(top: new BorderSide(color: _theme.disabledColor))),
        child: new Row(
          children: [
            new Expanded(
              flex: 1,
              child: new DragTarget(
                builder: (context, a, b) {
                  return new Icon(Icons.unarchive, size: 36.0);
                },
                onAccept: (data) {
                  _leftSwipe();
                  Navigator.pop(context);
                },
              ),
            ),
            new SizedBox(
              width: 1.0,
              height: 48.0,
              child: new Container(
                decoration:
                    new BoxDecoration(backgroundColor: _theme.disabledColor),
              ),
            ),
            new Expanded(
              flex: 1,
              child: new DragTarget(
                builder: (context, a, b) {
                  return new Icon(Icons.delete, size: 36.0);
                },
                onAccept: (data) {
                  _rightSwipe();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  void _onDragCancel() {
    Navigator.pop(context);
  }

  void _leftSwipe() {
    config.leftSwipe(config.toDo, false);
    Scaffold.of(context).showSnackBar(
          new SnackBar(
            backgroundColor: _theme.textTheme.body1.color,
            duration: new Duration(seconds: 2),
            content: new Text('ToDo restored',
                style: new TextStyle(color: _theme.accentColor)),
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
            backgroundColor: _theme.textTheme.body1.color,
            duration: new Duration(seconds: 2),
            content: new Text('ToDo deleted',
                style: new TextStyle(color: _theme.accentColor)),
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
    setState(() {
      _theme = Theme.of(context);
    });
    return new LongPressDraggable(
      key: new ObjectKey({'toDo': config.toDo}),
      data: config.toDo,
      feedback: new SizedBox(
        width: MediaQuery.of(context).size.width,
        child: new Card(
          child: new ListItem(
            enabled: false,
            dense: true,
            leading: new IconButton(
              icon: new Icon(
                  config.toDo['done']
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  color: config.toDo['done'] ? Colors.green[400] : null),
              onPressed: () {},
            ),
            title: new Text(config.toDo['title']),
            subtitle: new Text(config.toDo['subtitle']),
            onTap: () {},
          ),
        ),
      ),
      childWhenDragging: new Card(
        child: new ListItem(
          title: new Text('blub'),
        ),
      ),
      child: new ListItem(
        dense: true,
        enabled: false,
        leading: new IconButton(
          icon: new Icon(
              config.toDo['done']
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              color: config.toDo['done'] ? Colors.green[400] : null),
          onPressed: () {},
        ),
        title: new Text(config.toDo['title']),
        subtitle: new Text(config.toDo['subtitle']),
        onTap: () {},
      ),
      onDragStarted: () {
        _onDragStart();
      },
      onDraggableCanceled: (o, v) {
        _onDragCancel();
      },
    );
  }
}
