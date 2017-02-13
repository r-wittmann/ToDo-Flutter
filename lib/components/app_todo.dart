import 'package:flutter/material.dart';

class ToDo extends StatefulWidget {
  int indicator;
  var toDo;
  var toggleToDo;
  var leftSwipe;
  var undoLeftSwipe;
  var rightSwipe;
  var undoRightSwipe;

  var reorderList;

  ToDo(
      this.indicator,
      this.toDo,
      this.toggleToDo,
      this.leftSwipe,
      this.undoLeftSwipe,
      this.rightSwipe,
      this.undoRightSwipe,
      this.reorderList);

  @override
  State createState() => new ToDoState();
}

class ToDoState extends State<ToDo> {
  ThemeData _theme;
  bool _expanded = false;
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
  }

  void _onDragStart() {
    setState(() {
      _expanded = false;
    });
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
                    new BoxDecoration(backgroundColor: _theme.disabledColor),
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
    });
  }

  void _onDragCancel() {
    Navigator.pop(context);
  }

  void _leftSwipe() {
    config.leftSwipe(config.toDo, false);
    Scaffold.of(context).showSnackBar(
          new SnackBar(
            backgroundColor: _theme.canvasColor,
            duration: new Duration(seconds: 2),
            content: new Text(_leftText,
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
            backgroundColor: _theme.canvasColor,
            duration: new Duration(seconds: 2),
            content: new Text(_rightText,
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
    return new Stack(
      children: [
        new LongPressDraggable(
          data: config.toDo,
          feedback: new SizedBox(
            width: MediaQuery.of(context).size.width,
            child: new Card(
              elevation: 4,
              child: new ListItem(
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
              ),
            ),
          ),
          childWhenDragging: new Card(
            elevation: 0,
            child: new ListItem(
              dense: true,
              title: new Text(''),
              subtitle: new Text(''),
            ),
          ),
          child: new Card(
            elevation: 2,
            child: new Column(
              children: [
                new ListItem(
                  dense: true,
                  leading: new IconButton(
                    icon: new Icon(
                        config.toDo['done']
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: config.toDo['done'] ? Colors.green[400] : null),
                    onPressed: config.toggleToDo is Function
                        ? () => config.toggleToDo(config.toDo)
                        : () {},
                  ),
                  title: new Text(config.toDo['title']),
                  subtitle: new Text(config.toDo['subtitle']),
                  trailing: new IconButton(
                    icon: new Icon(
                      _expanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                    ),
                    onPressed: () {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    },
                  ),
                ),
                _expanded
                    ? new Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          new Expanded(
                            flex: 1,
                            child: new Container(
                              alignment: FractionalOffset.topLeft,
                              padding: new EdgeInsets.fromLTRB(
                                  24.0, 0.0, 24.0, 12.0),
                              child: new Text(
                                config.toDo['description'],
                                textScaleFactor: 0.9,
                              ),
                            ),
                          ),
                          config.indicator == 0
                              ? new Container(
                                  padding: new EdgeInsets.only(
                                      right: 12.0, bottom: 12.0),
                                  child: new IconButton(
                                    icon: new Icon(Icons.edit),
                                    onPressed: () {
//                                      Navigator.push(
//                                        context,
//                                        new MaterialPageRoute(
//                                          builder: (context) {
//                                            return new ToDoDetail();
//                                          },
//                                        ),
//                                      );
                                    },
                                  ),
                                )
                              : new Container(),
                        ],
                      )
                    : new Container(),
              ],
            ),
          ),
          onDragStarted: () {
            _onDragStart();
          },
          onDraggableCanceled: (o, v) {
            _onDragCancel();
          },
        ),
        new DragTarget(
          onAccept: (data) {
            config.reorderList(data, config.toDo);
            Navigator.pop(context);
          },
          builder: (context, a, b) {
            return new Container(height: 60.0);
          },
        ),
      ],
    );
  }
}
