import 'package:flutter/material.dart';
import 'package:flutter_multipage_form/empty_state.dart';
import 'package:flutter_multipage_form/form.dart';
import 'package:flutter_multipage_form/user.dart';

class MultiForm extends StatefulWidget {
  @override
  _MultiFormState createState() => _MultiFormState();
}

class _MultiFormState extends State<MultiForm> {
  List<User> users = [];
  List<GlobalKey<FormState>> _forms = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: .0,
        leading: Icon(
          Icons.wb_cloudy,
        ),
        title: Text('REGISTER USERS'),
        actions: <Widget>[
          FlatButton(
            child: Text('Save'),
            textColor: Colors.white,
            onPressed: onSave,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF30C1FF),
              Color(0xFF2AA7DC),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: users.length <= 0
            ? Center(
                child: EmptyState(
                  title: 'Oops',
                  message: 'Add form by tapping add button below',
                ),
              )
            : ListView.builder(
                addAutomaticKeepAlives: true,
                itemCount: users.length,
                itemBuilder: (_, i) => UserForm(
                      form: _forms[i],
                      onDelete: () {
                        onDelete(i);
                      },
                      user: users[i],
                    ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: onAddForm,
        foregroundColor: Colors.white,
      ),
    );
  }

  ///on form user deleted
  void onDelete(index) {
    setState(() {
      users.removeAt(index);
      _forms.removeAt(index);
    });
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var _form = GlobalKey<FormState>();
      var _user = User();
      users.add(_user);
      _forms.add(_form);
    });
  }

  ///form validator
  bool validate(int index) {
    var valid = _forms[index].currentState.validate();
    if (valid) _forms[index].currentState.save();
    return valid;
  }

  ///on save forms
  void onSave() {
    if (users.length > 0) {
      for (int i = 0; i < _forms.length; i++) {
        if (!validate(i)) {
          return;
        }
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => Scaffold(
                appBar: AppBar(
                  title: Text('List of Users'),
                ),
                body: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (_, i) => ListTile(
                        leading: CircleAvatar(
                          child: Text(users[i].fullName.substring(0, 1)),
                        ),
                        title: Text(users[i].fullName),
                        subtitle: Text(users[i].email),
                      ),
                ),
              ),
        ),
      );
    }
  }
}
