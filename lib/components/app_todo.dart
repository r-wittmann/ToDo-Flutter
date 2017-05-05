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
    widget.toggleExpand(widget.toDo, false);
    Scaffold.of(context).showBottomSheet((context) {
      return new ToDoAppBottomSheet(
          context,
          widget.indicator,
          widget.toDo,
          widget.leftSwipe,
          widget.undoLeftSwipe,
          widget.rightSwipe,
          widget.undoRightSwipe);
    });
  }

  void _onDragCancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    setState(() {
      _expanded = widget.expanded;
      _boxHeight = _expanded ? 148.0 : 0.0;
    });
    return new Stack(
      key: new ObjectKey(widget.toDo),
      children: [
        new LongPressDraggable(
          data: widget.toDo,
          feedback: new SizedBox(
            width: MediaQuery.of(context).size.width,
            child: new Card(
              elevation: 4,
              child: new ListItem(
                dense: true,
                leading: new IconButton(
                  icon: new Icon(
                    widget.toDo['done']
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: widget.toDo['done'] ? Colors.green[600] : null,
                  ),
                  onPressed: () {},
                ),
                title: new Text(widget.toDo['title']),
                subtitle: new Text(widget.toDo['subtitle']),
                trailing: widget.toDo['estimate'] is double
                    ? new Text(widget.toDo['estimate'].toString() + ' h')
                    : null,
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
                      widget.toDo['done']
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: widget.toDo['done'] ? Colors.green[600] : null,
                    ),
                    onPressed: widget.toggleToDo is Function
                        ? () => widget.toggleToDo(widget.toDo)
                        : null,
                  ),
                  title: new Text(widget.toDo['title']),
                  subtitle: new Text(widget.toDo['subtitle']),
                  trailing: _expanded
                      ? new Icon(Icons.keyboard_arrow_up)
                      : widget.toDo['estimate'] != null
                          ? new Text(widget.toDo['estimate'].toString() + ' h',
                              textScaleFactor: 0.9)
                          : new Container(),
                  onTap: () {
                    widget.toggleExpand(widget.toDo, !_expanded);
                  },
                ),
                new AnimatedContainer(
                  height: _boxHeight,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                  padding: new EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 12.0),
                  child: new DefaultTextStyle(
                    style: new TextStyle(
                        fontSize: 14.0,
                        color: _theme.brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Container(
                          height: 36.0,
                          child: new Text(
                            'Discription:   ' + widget.toDo['description'],
                            textAlign: TextAlign.justify,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        new Row(
                          children: [
                            new Expanded(
                              child: new Text('Category:'),
                            ),
                            new Text(widget.toDo['category']),
                          ],
                        ),
                        new SizedBox(
                          height: 8.0,
                        ),
                        new Row(
                          children: [
                            new Expanded(
                              child: new Text('Estimation:'),
                            ),
                            new Text(widget.toDo['estimate'] != null
                                ? widget.toDo['estimate'].toString() + ' h'
                                : 'no Estimation'),
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
                                return new ToDoAppDetail(
                                    widget.toDo, widget.toggleToDo);
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
            widget.reorderList(data, widget.toDo);
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
