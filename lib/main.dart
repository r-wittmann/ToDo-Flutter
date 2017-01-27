import 'package:ToDo/components/todo_app_container.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new ToDoApp());
}

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ToDoAppContainer();
  }
}

