import 'package:ToDo/components/app_bottom_sheet.dart';
import 'package:ToDo/components/app_detail.dart';
import 'package:flutter/material.dart';

class ToDo extends StatefulWidget {
  int indicator;
  var toDo;
  bool expanded;
  var toggleExpand;
  var toggleToDo;
  var leftSwipe;
  var undoLeftSwipe;
  var rightSwipe;
  var undoRightSwipe;

  var reorderList;

  ToDo(
      this.indicator,
      this.toDo,
      this.expanded,
      this.toggleExpand,
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
  bool _expanded;

  double _boxHeight;

  void _onDragStart() {
    config.toggleExpand(config.toDo, false);
    Scaffold.of(context).showBottomSheet((context) {
      return new ToDoAppBottomSheet(
          context,
          config.indicator,
          config.toDo,
          config.leftSwipe,
          config.undoLeftSwipe,
          config.rightSwipe,
          config.undoRightSwipe);
    });
  }

  void _onDragCancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _expanded = config.expanded;
      _boxHeight = _expanded ? 140.0 : 0.0;
    });
    return new Stack(
      key: new ObjectKey(config.toDo),
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
                    color: config.toDo['done'] ? Colors.green[600] : null,
                  ),
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
                      color: config.toDo['done'] ? Colors.green[600] : null,
                    ),
                    onPressed: config.toggleToDo is Function
                        ? () => config.toggleToDo(config.toDo)
                        : () {},
                  ),
                  title: new Text(config.toDo['title']),
                  subtitle: new Text(config.toDo['subtitle']),
                  trailing: _expanded
                      ? new Icon(Icons.keyboard_arrow_up)
                      : new Container(),
                  onTap: () {
                    config.toggleExpand(config.toDo, !_expanded);
                  },
                ),
                new AnimatedContainer(
                  height: _boxHeight,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                  padding: new EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 12.0),
                  child: new DefaultTextStyle(
                    style: new TextStyle(fontSize: 14.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Container(
                          height: 36.0,
                          child: new Text(
                            'Discription:   ' + config.toDo['description'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        new Row(
                          children: [
                            new Expanded(
                              child: new Text('Estimation:'),
                            ),
                            new Text('not implemented yet'),
                          ],
                        ),
                        new SizedBox(
                          height: 8.0,
                        ),
                        new Row(
                          children: [
                            new Expanded(
                              child: new Text('Due Date:'),
                            ),
                            new Text('not implemented yet'),
                          ],
                        ),
                        new Expanded(
                          child: new Container(),
                        ),
                        new FlatButton(
                          child: new Text('More'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return new ToDoAppDetail(config.toDo, config.toggleToDo);
                              }),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
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
            return new AnimatedContainer(
              curve: Curves.ease,
              duration: const Duration(milliseconds: 300),
              height: 60.0 + _boxHeight,
            );
          },
        ),
      ],
    );
  }
}
