import 'package:flutter/material.dart';

class ToDoAppCreate extends StatefulWidget {
  var createToDo;

  ToDoAppCreate(this.createToDo);

  @override
  State createState() => new ToDoAppCreateState();
}

class ToDoAppCreateState extends State<ToDoAppCreate> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  InputValue _title;
  InputValue _subtitle;
  InputValue _description;

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  bool _autovalidate = false;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  void _saveToDo(context) {
    FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true;
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      showInSnackBar('ToDo ${_title.text} created');
      config.createToDo({
        'title': _title.text,
        'subtitle': _subtitle.text,
        'description': _description.text,
        'done': false
      });
      Navigator.pop(context);
    }
  }

  void _dismissToDo(context) {
    FormState form = _formKey.currentState;
    form.reset();
    Navigator.pop(context);
  }

  String _validateTitle(InputValue value) {
    if (value.text.isEmpty) return 'Title is required.';
    return null;
  }

  String _validateSubtitle(InputValue value) {
    if (value.text.isEmpty) return 'Subtitle is required.';
    return null;
  }

  String _validateDescription(InputValue value) {
    if (value.text.isEmpty) return 'Description is required.';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        elevation: 2,
        leading: new IconButton(
            icon: new Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: new Text('Create ToDo'),
      ),
      body: new Form(
        key: _formKey,
        autovalidate: _autovalidate,
        child: new ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            new FormField<InputValue>(
              initialValue: InputValue.empty,
              onSaved: (InputValue val) {
                _title = val;
              },
              validator: _validateTitle,
              builder: (FormFieldState<InputValue> field) {
                return new Input(
                  autofocus: true,
                  icon: new Icon(Icons.label),
                  hintText: 'e.g. Feed the Unicorns',
                  labelText: 'Title',
                  value: field.value,
                  onChanged: field.onChanged,
                  errorText: field.errorText,
                );
              },
            ),
            new FormField<InputValue>(
              initialValue: InputValue.empty,
              onSaved: (InputValue val) {
                _subtitle = val;
              },
              validator: _validateSubtitle,
              builder: (FormFieldState<InputValue> field) {
                return new Input(
                  icon: new Icon(Icons.label),
                  hintText: 'e.g. Unicorns need lots of food!',
                  labelText: 'Subtitle',
                  value: field.value,
                  onChanged: field.onChanged,
                  errorText: field.errorText,
                );
              },
            ),
            new FormField<InputValue>(
              initialValue: InputValue.empty,
              onSaved: (InputValue val) {
                _description = val;
              },
              validator: _validateDescription,
              builder: (FormFieldState<InputValue> field) {
                return new Input(
                  icon: new Icon(Icons.label),
                  hintText: 'e.g More information about Unicorns.',
                  labelText: 'Description',
                  value: field.value,
                  onChanged: field.onChanged,
                  errorText: field.errorText,
                  maxLines: 5,
                );
              },
            ),
            new Container(
              alignment: FractionalOffset.topLeft,
              padding: const EdgeInsets.only(top: 12.0),
              child: new Row(
                children: [
                  new FlatButton(
                    child: new Text('Save'),
                    onPressed: () => _saveToDo(context),
                  ),
                  new FlatButton(
                    child: new Text('Dismiss'),
                    onPressed: () => _dismissToDo(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
