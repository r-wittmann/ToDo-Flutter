import 'package:flutter/material.dart';

class ToDoAppDetail extends StatefulWidget {
  var toDo;
  var toggleToDo;

  ToDoAppDetail(this.toDo, this.toggleToDo);

  @override
  State createState() => new ToDoAppDetailState();
}

class ToDoAppDetailState extends State<ToDoAppDetail> {
  var _editedToDo;
  bool _editActive = false;

  @override
  void initState() {
    super.initState();
    _editedToDo = new Map.from(config.toDo);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: _editActive
            ? new IconButton(
                icon: new Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _editedToDo = new Map.from(config.toDo);
                    _editActive = false;
                  });
                },
              )
            : null,
        title: new Text('ToDo Details'),
//        actions: [
//          _editActive
//              ? new IconButton(
//                  icon: new Icon(Icons.check),
//                  onPressed: () {
//                    print('Save ToDo, implementation in body needed');
//                  })
//              : new IconButton(
//                  icon: new Icon(Icons.edit),
//                  onPressed: () {
//                    setState(() {
//                      _editActive = true;
//                    });
//                  },
//                ),
//        ],
      ),
      body: new Card(
        elevation: 2,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            new ListItem(
              dense: false,
              leading: new IconButton(
                icon: new Icon(
                  _editedToDo['done']
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  color: _editedToDo['done'] ? Colors.green[600] : null,
                ),
                onPressed: config.toggleToDo is Function
                    ? () {
                        setState(() {
                          _editActive = true;
                          _editedToDo['done'] = !_editedToDo['done'];
                        });
                      }
                    : null,
              ),
              title: new Text(_editedToDo['title']),
              subtitle: new Text(_editedToDo['subtitle']),
            ),
            new DefaultTextStyle(
              style: new TextStyle(fontSize: 16.0),
              child: new Padding(
                padding: new EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text('Description:   ' + _editedToDo['description'],
                        textAlign: TextAlign.justify),
                    new SizedBox(
                      height: 8.0,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
