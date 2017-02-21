import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

class ToDoDataAccess {
  File _toDoFile;
  File _themeFile;

  Future<Map<String, dynamic>> loadToDos() async {
    await _loadToDoFile();
    String fileString = await _toDoFile.readAsString();
    Map<String, dynamic> fileObjects = await JSON.decode(fileString);

    return await fileObjects;
  }

  Future<Null> _loadToDoFile() async {
    String dir = (await PathProvider.getApplicationDocumentsDirectory()).path;
    _toDoFile = new File('$dir/todos.txt');
    // _toDoFile.delete();
    if (!await _toDoFile.exists()) {
      _toDoFile.create();
      await _toDoFile.writeAsString(JSON.encode({
        'toDos': [
          {
            'id': 1,
            'title': 'Welcome to ToDo',
            'subtitle': 'Tap here for more information',
            'description': 'ToDo Description I',
            'estimate': 0.5,
            'category': 'General',
            'done': false,
          },
          {
            'id': 2,
            'title': 'Get to know ToDo',
            'subtitle': 'Tap here for more information',
            'description': 'ToDo Description II',
            'estimate': 0.5,
            'category': 'General',
            'done': false,
          },
          {
            'id': 3,
            'title': 'Start using ToDo',
            'subtitle': 'Tap here for more information',
            'description': 'ToDo Description III',
            'estimate': null,
            'category': 'General',
            'done': false,
          }
        ],
        'archive': [],
        'trash': [],
        'categories': ['General']
      }));
    }
  }

  void saveToDos(objects) {
    _toDoFile.writeAsString(JSON.encode(objects));
  }

  Future<Map<String, dynamic>> loadTheme() async {
    await _loadThemeFile();
    String fileString = await _themeFile.readAsString();
    Map<String, dynamic> themeObjects = await JSON.decode(fileString);

    return await themeObjects;
  }

  Future<Null> _loadThemeFile() async {
    String dir = (await PathProvider.getApplicationDocumentsDirectory()).path;
    _themeFile = new File('$dir/theme.txt');
    // _themeFile.delete();
    if (!await _themeFile.exists()) {
      _themeFile.create();
      await _themeFile.writeAsString(JSON.encode({
        'theme': 'dark',
        'colorIndex': 0,
        'displayDone': true,
      }));
    }
  }

  void saveTheme(objects) {
    _themeFile.writeAsString(JSON.encode(objects));
  }
}
