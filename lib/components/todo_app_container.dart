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
  List _trashList = [];
  var _archiveObject;
  int _archiveIndex;
  int _deleteOrigin;
  var _deleteObject;
  int _deleteIndex;

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
    _trashList = toDoObjects['trash'];

    setState(() {
      _toDoList;
      _doneList;
      _archiveList;
      _trashList;
    });
  }

  void _createToDo(Map<String, dynamic> toDo) {
    setState(() {
      _toDoList.add(toDo);
    });
    _saveToDos();
  }

  void _toggleDone(toDo) {
    if (!toDo['done']) {
      setState(() {
        _toDoList.remove(toDo);
        toDo['done'] = true;
        _doneList.insert(0, toDo);
      });
    } else {
      setState(() {
        _doneList.remove(toDo);
        toDo['done'] = false;
        _toDoList.add(toDo);
      });
    }
    _saveToDos();
  }

  void _archiveToDo(toDo, bool undo) {
    if (!undo) {
      if (toDo['done']) {
        setState(() {
          _archiveObject = toDo;
          _archiveIndex = _doneList.indexOf(toDo);
          _doneList.remove(toDo);
          _archiveList.insert(0, toDo);
        });
      } else {
        setState(() {
          _archiveObject = toDo;
          _archiveIndex = _toDoList.indexOf(toDo);
          _toDoList.remove(toDo);
          _archiveList.insert(0, toDo);
        });
      }
    } else {
      if (_archiveObject['done']) {
        setState(() {
          _doneList.remove(_archiveObject);
          _archiveList.insert(_archiveIndex, _archiveObject);
        });
      } else {
        setState(() {
          _toDoList.remove(_archiveObject);
          _archiveList.insert(_archiveIndex, _archiveObject);
        });
      }
    }
    _saveToDos();
  }

  void _unarchiveToDo(toDo, bool undo) {
    if (!undo) {
      if (toDo['done']) {
        setState(() {
          _archiveObject = toDo;
          _archiveIndex = _archiveList.indexOf(toDo);
          _archiveList.remove(toDo);
          _doneList.insert(0, toDo);
        });
      } else {
        setState(() {
          _archiveObject = toDo;
          _archiveIndex = _archiveList.indexOf(toDo);
          _archiveList.remove(toDo);
          _toDoList.insert(0, toDo);
        });
      }
    } else {
      if (_archiveObject['done']) {
        setState(() {
          _archiveList.remove(_archiveObject);
          _doneList.insert(_archiveIndex, _archiveObject);
        });
      } else {
        setState(() {
          _archiveList.remove(_archiveObject);
          _toDoList.insert(_archiveIndex, _archiveObject);
        });
      }
    }
    _saveToDos();
  }

  void _deleteToDo(toDo, bool undo) {
    if (!undo) {
      if (toDo['done']) {
        setState(() {
          _deleteObject = toDo;
          _deleteIndex = _doneList.indexOf(toDo);
          _doneList.remove(toDo);
          _trashList.insert(0, toDo);
        });
      } else {
        setState(() {
          _deleteObject = toDo;
          _deleteIndex = _toDoList.indexOf(toDo);
          _toDoList.remove(toDo);
          _trashList.insert(0, toDo);
        });
      }
    } else {
      if (_deleteObject['done']) {
        setState(() {
          _doneList.remove(_deleteObject);
          _trashList.insert(_deleteIndex, _deleteObject);
        });
      } else {
        setState(() {
          _toDoList.remove(_deleteObject);
          _trashList.insert(_deleteIndex, _deleteObject);
        });
      }
    }
    _saveToDos();
  }

  void _undeleteToDo(toDo, bool undo) {
    if (!undo) {
      if (toDo['done']) {
        setState(() {
          _deleteObject = toDo;
          _deleteIndex = _trashList.indexOf(toDo);
          _trashList.remove(toDo);
          _doneList.insert(0, toDo);
        });
      } else {
        setState(() {
          _deleteObject = toDo;
          _deleteIndex = _trashList.indexOf(toDo);
          _trashList.remove(toDo);
          _toDoList.insert(0, toDo);
        });
      }
    } else {
      if (_deleteObject['done']) {
        setState(() {
          _trashList.remove(_deleteObject);
          _doneList.insert(_deleteIndex, _deleteObject);
        });
      } else {
        setState(() {
          _trashList.remove(_deleteObject);
          _toDoList.insert(_deleteIndex, _deleteObject);
        });
      }
    }
    _saveToDos();
  }

  void _deleteArchive(toDo) {}
  void _undeleteArchive(toDo) {}

  void _saveToDos() {
    _dataAccess.saveToDos({
      'toDos': _toDoList,
      'done': _doneList,
      'archive': _archiveList,
      'trash': _trashList
    });
  }

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
      routes: {
        '/': (_) => new ToDoAppScaffold(
            0,
            []..addAll(_toDoList)..addAll(_doneList),
            _toggleDone,
            _archiveToDo,
            _unarchiveToDo,
            _deleteToDo,
            _undeleteToDo,
            _createToDo,
            _color,
            _brightness,
            _changeTheme,
            _changeColor),
        '/archive': (_) => new ToDoAppScaffold(
            1,
            _archiveList,
            null,
            _unarchiveToDo,
            _archiveToDo,
            _deleteArchive,
            _undeleteArchive,
            null,
            _color,
            _brightness,
            _changeTheme,
            _changeColor),
        '/trash': (_) => new ToDoAppScaffold(
            2,
            _trashList,
            null,
            null,
            null,
            _undeleteToDo,
            _deleteToDo,
            null,
            _color,
            _brightness,
            _changeTheme,
            _changeColor)
      },
    );
  }
}
