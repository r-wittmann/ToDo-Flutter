import 'dart:async';
import 'package:ToDo/components/app_scaffold.dart';
import 'package:ToDo/data_access.dart';
import 'package:flutter/material.dart';

class ToDoAppContainer extends StatefulWidget {
  @override
  State createState() => new ToDoAppContainerState();
}

class ToDoAppContainerState extends State<ToDoAppContainer> {
  bool _toDosLoaded = false;
  List _toDoList = [];
  List _archiveList = [];
  List _trashList = [];
  var _archiveObject;
  int _archiveIndex;
  var _deleteObject;
  int _deleteIndex;

  bool _useDarkTheme = true;
  Brightness _brightness = Brightness.dark;

  int _colorIndex = 0;
  Color _color = Colors.red[800];

  ToDoDataAccess _dataAccess = new ToDoDataAccess();

  Future<Null> _loadTheme() async {
    Map<String, dynamic> themeObjects = await _dataAccess.loadTheme();

    _useDarkTheme = themeObjects['theme'] == 'dark';
    _brightness =
        themeObjects['theme'] == 'dark' ? Brightness.dark : Brightness.light;

    _colorIndex = themeObjects['colorIndex'];
    _color = _useDarkTheme
        ? _darkColorList[_colorIndex]
        : _lightColorList[_colorIndex];
  }

  Future _loadToDos() async {
    setState(() {
      _toDosLoaded = true;
    });

    Map<String, dynamic> toDoObjects = await _dataAccess.loadToDos();
    _toDoList = toDoObjects['toDos'];
    _archiveList = toDoObjects['archive'];
    _trashList = toDoObjects['trash'];

    setState(() {
      _toDoList;
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
    _toDoList.remove(toDo);
    toDo['done'] = !toDo['done'];
    if (toDo['done'])
      _toDoList.insert(0, toDo);
    else
      _toDoList.add(toDo);

    setState(() {
      _toDoList;
    });
    _saveToDos();
  }

  void _archiveToDo(toDo, bool undo) {
    if (!undo) {
      setState(() {
        _archiveObject = toDo;
        _archiveIndex = _toDoList.indexOf(toDo);
        _toDoList.remove(toDo);
        _archiveList.insert(0, toDo);
      });
    } else {
      setState(() {
        _toDoList.remove(_archiveObject);
        _archiveList.insert(_archiveIndex, _archiveObject);
      });
    }
    _saveToDos();
  }

  void _unarchiveToDo(toDo, bool undo) {
    if (!undo) {
      setState(() {
        _archiveObject = toDo;
        _archiveIndex = _archiveList.indexOf(toDo);
        _archiveList.remove(toDo);
        _toDoList.insert(0, toDo);
      });
    } else {
      setState(() {
        _archiveList.remove(_archiveObject);
        _toDoList.insert(_archiveIndex, _archiveObject);
      });
    }
    _saveToDos();
  }

  void _deleteToDo(toDo, bool undo) {
    if (!undo) {
      setState(() {
        _deleteObject = toDo;
        _deleteIndex = _toDoList.indexOf(toDo);
        _toDoList.remove(toDo);
        _trashList.insert(0, toDo);
      });
    } else {
      setState(() {
        _toDoList.remove(_deleteObject);
        _trashList.insert(_deleteIndex, _deleteObject);
      });
    }
    _saveToDos();
  }

  void _undeleteToDo(toDo, bool undo) {
    if (!undo) {
      setState(() {
        _deleteObject = toDo;
        _deleteIndex = _trashList.indexOf(toDo);
        _trashList.remove(toDo);
        _toDoList.insert(0, toDo);
      });
    } else {
      setState(() {
        _trashList.remove(_deleteObject);
        _toDoList.insert(_deleteIndex, _deleteObject);
      });
    }
    _saveToDos();
  }

  void _deleteArchive(toDo, bool undo) {
    if (!undo) {
      setState(() {
        _deleteObject = toDo;
        _deleteIndex = _archiveList.indexOf(toDo);
        _archiveList.remove(toDo);
        _trashList.insert(0, toDo);
      });
    } else {
      setState(() {
        _archiveList.remove(_deleteObject);
        _trashList.insert(_deleteIndex, _deleteObject);
      });
    }
    _saveToDos();
  }

  void _undeleteArchive(toDo, bool undo) {
    if (!undo) {
      setState(() {
        _deleteObject = toDo;
        _deleteIndex = _trashList.indexOf(toDo);
        _trashList.remove(toDo);
        _archiveList.insert(0, toDo);
      });
    } else {
      setState(() {
        _trashList.remove(_deleteObject);
        _archiveList.insert(_deleteIndex, _deleteObject);
      });
    }
    _saveToDos();
  }

  void _emptyTrash(toDo, bool undo) {
    if (!undo) {
      setState(() {
        _deleteObject = toDo;
        _deleteIndex = _trashList.indexOf(toDo);
        _trashList.remove(toDo);
      });
    } else if (undo) {
      setState(() {
        _trashList.insert(_deleteIndex, _deleteObject);
      });
    } else {
      setState(() {
        _trashList.clear();
      });
    }
    _saveToDos();
  }

  void _restoreTrash(toDo, bool undo) {
    setState(() {
      _trashList.insert(_deleteIndex, _deleteObject);
    });
    _saveToDos();
  }

  void _reorderList(droppedToDo, referenceToDo) {
    if (droppedToDo == referenceToDo) return;
    int indicator = 0;

    if (_toDoList.contains(droppedToDo)) {
      if (_toDoList.indexOf(droppedToDo) < _toDoList.indexOf(referenceToDo))
        indicator = 1;
      _toDoList.remove(droppedToDo);
      _toDoList.insert(
          _toDoList.indexOf(referenceToDo) + indicator, droppedToDo);
    } else if (_archiveList.contains(droppedToDo)) {
      if (_archiveList.indexOf(droppedToDo) <
          _archiveList.indexOf(referenceToDo)) indicator = 1;
      _archiveList.remove(droppedToDo);
      _archiveList.insert(
          _archiveList.indexOf(referenceToDo) + indicator, droppedToDo);
    } else if (_trashList.contains(droppedToDo)) {
      if (_trashList.indexOf(droppedToDo) < _trashList.indexOf(referenceToDo))
        indicator = 1;
      _trashList.remove(droppedToDo);
      _trashList.insert(
          _trashList.indexOf(referenceToDo) + indicator, droppedToDo);
    }
    setState(() {
      _toDoList;
      _archiveList;
      _trashList;
    });
    _saveToDos();
  }

  void _saveToDos() {
    _toDoList.sort((a, b) {
      if (a['done'] == b['done'])
        return 0;
      else if (a['done'])
        return 1;
      else
        return -1;
    });
    _dataAccess.saveToDos(
        {'toDos': _toDoList, 'archive': _archiveList, 'trash': _trashList});
  }

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
    _saveTheme();
  }

  void _saveTheme() {
    _dataAccess.saveTheme(
        {'theme': _useDarkTheme ? 'dark' : 'light', 'colorIndex': _colorIndex});
  }

  @override
  Widget build(BuildContext context) {
    if (!_toDosLoaded) {
      _loadToDos();
      _loadTheme();
    }

    return new MaterialApp(
      theme: new ThemeData(
        primaryColor: _color,
        brightness: _brightness,
        accentColor:
            _brightness == Brightness.dark ? Colors.white70 : Colors.black54,
        primaryIconTheme: new IconThemeData(color: Colors.white),
        iconTheme: new IconThemeData(
          color:
              _brightness == Brightness.dark ? Colors.white70 : Colors.black54,
        ),
        cardColor:
            _brightness == Brightness.dark ? Colors.grey[850] : Colors.grey[50],
      ),
      routes: {
        '/': (_) => new ToDoAppScaffold(
            0,
            _toDosLoaded,
            _toDoList,
            _toggleDone,
            _archiveToDo,
            _unarchiveToDo,
            _deleteToDo,
            _undeleteToDo,
            _createToDo,
            _emptyTrash,
            _reorderList,
            _color,
            _brightness,
            _changeTheme,
            _changeColor),
        '/archive': (_) => new ToDoAppScaffold(
            1,
            _toDosLoaded,
            _archiveList,
            null,
            _unarchiveToDo,
            _archiveToDo,
            _deleteArchive,
            _undeleteArchive,
            null,
            _emptyTrash,
            _reorderList,
            _color,
            _brightness,
            _changeTheme,
            _changeColor),
        '/trash': (_) => new ToDoAppScaffold(
            2,
            _toDosLoaded,
            _trashList,
            null,
            _undeleteToDo,
            _deleteToDo,
            _emptyTrash,
            _restoreTrash,
            null,
            _emptyTrash,
            _reorderList,
            _color,
            _brightness,
            _changeTheme,
            _changeColor)
      },
    );
  }
}
