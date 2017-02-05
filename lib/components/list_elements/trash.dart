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
  ThemeData _theme;
  void _onDragStart() {
    Scaffold.of(context).showBottomSheet((context) {
      return new Container(
        decoration: new BoxDecoration(
            border:
                new Border(top: new BorderSide(color: _theme.disabledColor))),
        child: new Container(
          height: 48.0,
          padding: new EdgeInsets.symmetric(vertical: 6.0),
          alignment: FractionalOffset.center,
          child: new DragTarget(
            builder: (context, a, b) {
              return new Icon(Icons.restore_from_trash, size: 36.0);
            },
            onAccept: (data) {
              _rightSwipe();
              Navigator.pop(context);
            },
          ),
        ),
      );
    });
  }

  void _onDragCancel() {
    Navigator.pop(context);
  }

  void _rightSwipe() {
    config.rightSwipe(config.toDo, false);
    Scaffold.of(context).showSnackBar(
          new SnackBar(
              backgroundColor: _theme.canvasColor,
            duration: new Duration(seconds: 2),
            content: new Text('ToDo restored',
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
