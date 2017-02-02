import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

class ToDoDataAccess {
  File _toDoFile;

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
            'done': false,
          },
          {
            'id': 2,
            'title': 'Get to know ToDo',
            'subtitle': 'Tap here for more information',
            'description': 'ToDo Description II',
            'done': false,
          },
          {
            'id': 3,
            'title': 'Start using ToDo',
            'subtitle': 'Tap here for more information',
            'description': 'ToDo Description III',
            'done': false,
          }
        ],
        'done': [],
        'archive': [],
        'trash': []
      }));
    }
  }

  void saveToDos(objects) {
    _toDoFile.writeAsString(JSON.encode(objects));
  }
}
