import 'package:flutter/material.dart';
import 'package:realtimedatabasewithfirebase/user.dart';

class AddUserDialog {
  final uName = TextEditingController();
  final uEmail = TextEditingController();
  final uAge = TextEditingController();
  final uMobile = TextEditingController();
  User user;

  static const TextStyle linkStyle = const TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  Widget buildAboutDialog(BuildContext context,
      AddUserCallback _myHomePageState, bool isEdit, User user) {
    if (user != null) {
      this.user = user;
      uName.text = user.name;
      uEmail.text = user.email;
      uAge.text = user.age;
      uMobile.text = user.mobile;
    }

    return new AlertDialog(
      title: new Text(isEdit ? 'Edit detail!' : 'Add new user!'),
      content: new SingleChildScrollView(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTextField("Name", uName),
            getTextField("Email", uEmail),
            getTextField("Age", uAge),
            getTextField("Mobile", uMobile),
            new GestureDetector(
              onTap: () => onTap(isEdit, _myHomePageState, context),
              child: new Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: getAppBorderButton(isEdit ? "Edit" : "Add",
                    EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTextField(
      String inputBoxName, TextEditingController inputBoxController) {
    var loginBtn = new Padding(
      padding: const EdgeInsets.all(5.0),
      child: new TextFormField(
        controller: inputBoxController,
        decoration: new InputDecoration(
          hintText: inputBoxName,
        ),
      ),
    );

    return loginBtn;
  }

  Widget getAppBorderButton(String buttonLabel, EdgeInsets margin) {
    var loginBtn = new Container(
      margin: margin,
      padding: EdgeInsets.all(10.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: new BorderRadius.all(const Radius.circular(7.0)),
      ),
      child: new Text(
        buttonLabel,
        style: new TextStyle(
          color: Colors.blueAccent,
          fontSize: 25.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
        ),
      ),
    );
    return loginBtn;
  }

  User getData(bool isEdit) {
    return new User(isEdit ? user.id : "", uName.text, uEmail.text,
        uAge.text, uMobile.text);
  }

  onTap(bool isEdit, AddUserCallback _myHomePageState, BuildContext context) {
    if (isEdit) {
      _myHomePageState.update(getData(isEdit));
    } else {
      _myHomePageState.addUser(getData(isEdit));
    }

    Navigator.of(context).pop();

  }
}
//Call back of user dashboad
abstract class AddUserCallback {
  void addUser(User user);

  void update(User user);
}