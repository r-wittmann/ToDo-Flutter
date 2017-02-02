import 'package:flutter/material.dart';

class ToDoAppDrawer extends StatelessWidget {
  Color color;
  Brightness brightness;
  var changeTheme;
  var changeColor;

  ToDoAppDrawer(color, brightness, changeTheme, changeColor) {
    this.color = color;
    this.brightness = brightness;
    this.changeTheme = changeTheme;
    this.changeColor = changeColor;
  }

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new Block(
        children: [
          new DrawerHeader(
            decoration: new BoxDecoration(
                backgroundColor: color),
          ),
          new DrawerItem(
            icon: new Icon(Icons.check_box),
            child: new Text('ToDo List',style: new TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.popAndPushNamed(context, '/');
            }
          ),
          new DrawerItem(
            icon: new Icon(Icons.archive),
            child: new Text('Archive'),
              onPressed: () {
                Navigator.popAndPushNamed(context, '/archive');
              }
          ),
          new DrawerItem(
            icon: new Icon(Icons.delete),
            child: new Text('Trash'),
              onPressed: () {
                Navigator.popAndPushNamed(context, '/trash');
              }
          ),
          new Divider(),
          new DrawerItem(
              icon: new Icon(
                  brightness == Brightness.dark ? Icons.brightness_7 : Icons.brightness_5),
              child: new Text('Change Theme'),
              onPressed: () {
                changeTheme();
              }
          ),
          new DrawerItem(
              icon: new Icon(Icons.format_paint,
                  color: color),
              child: new Text('Change Color'),
              onPressed: () {
                changeColor(false);
              }
          ),
          new Divider(),
          new DrawerItem(
            icon: new Icon(Icons.calendar_today),
            child: new Text('Use Deadlines (maybe)'),
          ),
          new DrawerItem(
            icon: new Icon(Icons.delete_forever),
            child: new Text('Empty Trash'),
          ),
        ],
      ),
    );
  }
}
