import 'package:flutter/material.dart';

class ToDoAppDrawer extends StatelessWidget {
  int indicator;
  Color color;
  Brightness brightness;
  var changeTheme;
  var changeColor;

  ToDoAppDrawer(this.indicator, this.color, this.brightness, this.changeTheme,
      this.changeColor);

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new Block(
        children: [
          new DrawerHeader(
            decoration: new BoxDecoration(backgroundColor: color),
          ),
          new Container(
            decoration: indicator == 0
                ? new BoxDecoration(
                    backgroundColor: new Color.fromRGBO(125, 125, 125, 0.3))
                : null,
            child: new DrawerItem(
                icon: new Icon(Icons.check_box),
                child: new Text('ToDo List'),
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                }),
          ),
          new Container(
            decoration: indicator == 1
                ? new BoxDecoration(
                backgroundColor: new Color.fromRGBO(125, 125, 125, 0.3))
                : null,
            child: new DrawerItem(
                icon: new Icon(Icons.archive),
                child: new Text('Archive'),
                onPressed: () {
                  Navigator.pushNamed(context, '/archive');
                }),
          ),
          new Container(
            decoration: indicator == 2
                ? new BoxDecoration(
                backgroundColor: new Color.fromRGBO(125, 125, 125, 0.3))
                : null,
            child: new DrawerItem(
                icon: new Icon(Icons.delete),
                child: new Text('Trash'),
                onPressed: () {
                  Navigator.pushNamed(context, '/trash');
                }),
          ),
          new Divider(),
          new DrawerItem(
              icon: new Icon(brightness == Brightness.dark
                  ? Icons.brightness_7
                  : Icons.brightness_5),
              child: new Text('Change Theme'),
              onPressed: () {
                changeTheme();
              }),
          new DrawerItem(
              icon: new Icon(Icons.format_paint, color: color),
              child: new Text('Change Color'),
              onPressed: () {
                changeColor(false);
              }),
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
