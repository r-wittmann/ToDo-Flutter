import 'package:flutter/material.dart';

class ToDoArchiveElement extends StatefulWidget {
  var toDo;
  var archiveToDo;
  var unarchiveToDo;
  var deleteToDo;
  var undoDelete;

  ToDoArchiveElement(this.toDo, this.archiveToDo, this.unarchiveToDo,
      this.deleteToDo, this.undoDelete);

  @override
  State createState() => new ToDoArchiveElementState();
}

class ToDoArchiveElementState extends State<ToDoArchiveElement>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward();

    _animation = new CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _controller.stop();
    super.dispose();
  }

  void _deleteItem() {
    config.deleteToDo(config.toDo);
    Scaffold.of(context).showSnackBar(
          new SnackBar(
            backgroundColor: Colors.grey[800],
            duration: new Duration(seconds: 2),
            content: new Text('You deleted a ToDo'),
            action: new SnackBarAction(
                label: 'UNDO',
                onPressed: () {
                  config.undoDelete();
                }),
          ),
        );
  }

  void _unarchiveItem() {
    config.unarchiveToDo(config.toDo);
    Scaffold.of(context).showSnackBar(
          new SnackBar(
            backgroundColor: Colors.grey[800],
            duration: new Duration(seconds: 2),
            content: new Text('You unarchived a ToDo'),
            action: new SnackBarAction(
                label: 'UNDO',
                onPressed: () {
                  config.archiveToDo(config.toDo);
                }),
          ),
        );
  }

  Widget _buildListItem(BuildContext context, Widget child) {
    return new SizedBox(
        height: (60 * _animation.value),
        child: new Opacity(
          opacity: _animation.value,
          child: new Dismissable(
            key: new ObjectKey(config.toDo),
            resizeDuration: const Duration(milliseconds: 500),
            background: new Container(
              decoration: new BoxDecoration(backgroundColor: Colors.red[400]),
              child: new ListItem(
                leading: new Icon(Icons.delete, color: Colors.white),
              ),
            ),
            secondaryBackground: new Container(
              decoration: new BoxDecoration(backgroundColor: Colors.blue[500]),
              child: new ListItem(
                trailing: new Icon(Icons.unarchive, color: Colors.white),
              ),
            ),
            child: new ListItem(
              enabled: false,
              dense: true,
              leading: new Checkbox(
                activeColor: Colors.grey[400],
                value: config.toDo['done'],
                onChanged: (value) {},
              ),
              title: new Text(config.toDo['title']),
              subtitle: new Text(config.toDo['subtitle']),
            ),
            onDismissed: (direction) {
              if (direction == DismissDirection.startToEnd)
                _deleteItem();
              else
                _unarchiveItem();
            },
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      animation: _animation,
      builder: _buildListItem,
    );
  }
}
