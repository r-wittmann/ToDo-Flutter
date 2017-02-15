import 'package:flutter/material.dart';

class ToDoAppBottomSheet extends StatefulWidget {
  BuildContext context;
  int indicator;
  var toDo;
  var leftSwipe;
  var undoLeftSwipe;
  var rightSwipe;
  var undoRightSwipe;

  ToDoAppBottomSheet(this.context, this.indicator, this.toDo, this.leftSwipe,
      this.undoLeftSwipe, this.rightSwipe, this.undoRightSwipe);

  @override
  State createState() => new ToDoAppBottomSheetState();
}

class ToDoAppBottomSheetState extends State<ToDoAppBottomSheet> {
  ThemeData _theme;
  String _leftText;
  String _rightText;
  Icon _leftIcon;
  Icon _rightIcon;

  @override
  void initState() {
    super.initState();
    switch (config.indicator) {
      case 0:
        _leftText = 'ToDo archived';
        _rightText = 'ToDo deleted';
        _leftIcon = new Icon(Icons.archive, size: 36.0);
        _rightIcon = new Icon(Icons.delete, size: 36.0);
        break;
      case 1:
        _leftText = 'ToDo restored';
        _rightText = 'ToDo deleted';
        _leftIcon = new Icon(Icons.unarchive, size: 36.0);
        _rightIcon = new Icon(Icons.delete, size: 36.0);
        break;
      default:
        _leftText = 'ToDo restored';
        _rightText = 'ToDo deleted';
        _leftIcon = new Icon(Icons.restore_from_trash, size: 36.0);
        _rightIcon = new Icon(Icons.delete_forever, size: 36.0);
        break;
    }
    _theme = Theme.of(config.context);
  }

  void _leftSwipe() {
    config.leftSwipe(config.toDo, false);
    Scaffold.of(config.context).showSnackBar(
          new SnackBar(
            duration: new Duration(seconds: 2),
            content: new Text(_leftText),
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
    Scaffold.of(config.context).showSnackBar(
          new SnackBar(
            duration: new Duration(seconds: 2),
            content: new Text(_rightText),
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
    return new Container(
      decoration: new BoxDecoration(
          border: new Border(top: new BorderSide(color: _theme.dividerColor))),
      child: new Row(
        children: [
          new Expanded(
            flex: 1,
            child: new DragTarget(
              builder: (context, a, b) {
                return _leftIcon;
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
                  new BoxDecoration(backgroundColor: _theme.dividerColor),
            ),
          ),
          new Expanded(
            flex: 1,
            child: new DragTarget(
              builder: (context, a, b) {
                return _rightIcon;
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
  }
}
