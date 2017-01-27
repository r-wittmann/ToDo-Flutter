import 'dart:async';
import 'package:ToDo/components/todo_app_scaffold.dart';
import 'package:ToDo/todo_data_access.dart';
import 'package:flutter/material.dart';

class ToDoAppContainer extends StatefulWidget {
  @override
  State createState() => new ToDoAppContainerState();
}

class ToDoAppContainerState extends State<ToDoAppContainer> {
  bool _toDosLoaded = false;
  List _toDoList = [];
  List _doneList = [];
  List _archiveList = [];
  var _undoObject;
  int _undoIndex;

  ToDoDataAccess _dataAccess;

  Future _loadToDos() async {
    setState(() {
      _toDosLoaded = true;
    });

    _dataAccess = new ToDoDataAccess();
    Map<String, dynamic> toDoObjects = await _dataAccess.loadToDos();
    _toDoList = toDoObjects['toDos'];
    _doneList = toDoObjects['done'];
    _archiveList = toDoObjects['archive'];

    setState(() {
      _toDoList;
      _doneList;
      _archiveList;
    });
  }

  void _doToDo(toDo) {
    setState(() {
      _toDoList.remove(toDo);
      _doneList.add(toDo);
    });
    _dataAccess.saveToDos(
        {'toDos': _toDoList, 'done': _doneList, 'archive': _archiveList});
  }

  void _undoDone(toDo) {
    setState(() {
      _doneList.remove(toDo);
      _toDoList.add(toDo);
    });
    _dataAccess.saveToDos(
        {'toDos': _toDoList, 'done': _doneList, 'archive': _archiveList});
  }

  void _archiveToDo(toDo, bool undo) {
    if (!undo) {
      setState(() {
        _undoObject = toDo;
        _undoIndex = _toDoList.indexOf(toDo);
        _toDoList.remove(toDo);
        _archiveList.add(toDo);
      });
    } else {
      setState(() {
        _toDoList.remove(_undoObject);
        _archiveList.insert(_undoIndex, _undoObject);
      });
    }
    _dataAccess.saveToDos(
        {'toDos': _toDoList, 'done': _doneList, 'archive': _archiveList});
  }

  void _archiveDone(toDo, bool undo) {
    if (!undo) {
      setState(() {
        _undoObject = toDo;
        _undoIndex = _doneList.indexOf(toDo);
        _doneList.remove(toDo);
        _archiveList.add(toDo);
      });
    } else {
      setState(() {
        _doneList.remove(_undoObject);
        _archiveList.insert(_undoIndex, _undoObject);
      });
    }
    _dataAccess.saveToDos(
        {'toDos': _toDoList, 'done': _doneList, 'archive': _archiveList});
  }

  void _unarchiveToDo(toDo, bool undo) {
    if(!undo) {
      setState(() {
        _undoObject = toDo;
        _undoIndex = _archiveList.indexOf(toDo);
        _archiveList.remove(toDo);
        _toDoList.add(toDo);
      });
    } else {
      setState(() {
        _archiveList.remove(_undoObject);
        _toDoList.insert(_undoIndex, _undoObject);
      });
    }
    _dataAccess.saveToDos(
        {'toDos': _toDoList, 'done': _doneList, 'archive': _archiveList});
  }

  void _unarchiveDone(toDo, bool undo) {
    if(!undo) {
      setState(() {
        _undoObject = toDo;
        _undoIndex = _archiveList.indexOf(toDo);
        _archiveList.remove(toDo);
        _doneList.add(toDo);
      });
    } else {
      setState(() {
        _archiveList.remove(_undoObject);
        _doneList.insert(_undoIndex, _undoObject);
      });
    }
    _dataAccess.saveToDos(
        {'toDos': _toDoList, 'done': _doneList, 'archive': _archiveList});
  }

  void _deleteToDo(toDo) {}
  void _undeleteToDo(toDo) {}
  void _deleteDone(toDo) {}
  void _undeleteDone(toDo) {}
  void _deleteArchive(toDo) {}
  void _undeleteArchive(toDo) {}

//  void _updateToDo(toDo) {
//    _toDoList.forEach((value) {
//      if (value['id'] == toDo['id']) value = toDo;
//    });
//
//    if (!_toDoList.contains(toDo)) {
//      toDo['id'] = _toDoList.length + 1;
//      _toDoList.insert(0, toDo);
//    }
//
//    _toDoList.sort((a, b) {
//      if (a['done'] == b['done'])
//        return 0;
//      else if (a['done'] && !b['done'])
//        return 1;
//      else if (!a['done'] && b['done']) return -1;
//    });
//
//    setState(() {
//      _toDoList;
//    });
//
//    _dataAccess.saveToDos({'toDos': _toDoList, 'archive': _archiveList});
//  }
//
//  void _archiveToDo(toDo) {
//    setState(() {
//      _archivedToDo = toDo;
//      _archivedToDoIndex = _toDoList.indexOf(toDo);
//      _toDoList.remove(toDo);
//      _archiveList.insert(0, toDo);
//    });
//
//    _dataAccess.saveToDos({'toDos': _toDoList, 'archive': _archiveList});
//  }
//
//  void _unarchiveToDo(toDo) {
//    setState(() {
//      _archiveList.remove(toDo);
//      _toDoList.insert(0, toDo);
//    });
//
//    _dataAccess.saveToDos({'toDos': _toDoList, 'archive': _archiveList});
//  }
//
//  void _undoArchive() {
//    setState(() {
//      _toDoList.insert(_archivedToDoIndex, _archivedToDo);
//      _archiveList.remove(_archivedToDo);
//    });
//
//    _dataAccess.saveToDos({'toDos': _toDoList, 'archive': _archiveList});
//  }
//
//  void _deleteToDo(toDo) {
//    if (_toDoList.contains(toDo)) {
//      setState(() {
//        _deletedToDo = toDo;
//        _deletedToDoIndex = _toDoList.indexOf(toDo);
//        _toDoList.remove(toDo);
//      });
//    } else if (_archiveList.contains(toDo)) {
//      setState(() {
//        _deletedToDo = toDo;
//        _deletedToDoIndex = -_toDoList.indexOf(toDo) - 1;
//        _archiveList.remove(toDo);
//      });
//    }
//
//    _dataAccess.saveToDos({'toDos': _toDoList, 'archive': _archiveList});
//  }
//
//  void _undoDelete() {
//    if (_deletedToDoIndex >= 0) {
//      setState(() {
//        _toDoList.insert(_deletedToDoIndex, _deletedToDo);
//      });
//    } else {
//      setState(() {
//        _archiveList.insert(-_deletedToDoIndex + 1, _deletedToDo);
//      });
//    }
//    _dataAccess.saveToDos({'toDos': _toDoList, 'archive': _archiveList});
//  }

  bool _useDarkTheme = true;
  Brightness _brightness = Brightness.dark;

  int _colorIndex = 0;
  Color _color = Colors.red[800];

  List<Color> _darkColorList = [
    Colors.red[800],
    Colors.deepPurple[800],
    Colors.blue[800],
    Colors.teal[800],
    Colors.green[800],
    Colors.orange[900]
  ];
  List<Color> _lightColorList = [
    Colors.red[500],
    Colors.deepPurple[500],
    Colors.blue[500],
    Colors.teal[500],
    Colors.green[500],
    Colors.orange[500]
  ];

  void _changeTheme() {
    setState(() {
      _useDarkTheme = !_useDarkTheme;
      _brightness = Brightness.values[_useDarkTheme ? 0 : 1];
    });
    _changeColor(true);
  }

  void _changeColor(themeChange) {
    if (!themeChange) {
      setState(() {
        _colorIndex = ++_colorIndex % _darkColorList.length;
      });
    }
    setState(() {
      _color = _useDarkTheme
          ? _darkColorList[_colorIndex]
          : _lightColorList[_colorIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_toDosLoaded) {
      _loadToDos();
    }

    return new MaterialApp(
      theme: new ThemeData(
        primaryColor: _color,
        brightness: _brightness,
        accentColor: _color,
        primaryIconTheme: new IconThemeData(color: Colors.white),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      home: new ToDoAppScaffold(
          _toDoList,
          _doneList,
          _archiveList,
          _doToDo,
          _undoDone,
          _archiveToDo,
          _unarchiveToDo,
          _archiveDone,
          _unarchiveDone,
          _deleteToDo,
          _undeleteToDo,
          _deleteDone,
          _undeleteDone,
          _deleteArchive,
          _undeleteArchive,
          _color,
          _brightness,
          _changeTheme,
          _changeColor),
    );
  }
}
