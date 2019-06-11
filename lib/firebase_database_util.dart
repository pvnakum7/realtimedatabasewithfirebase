import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:realtimedatabasewithfirebase/user.dart';


class FirebaseDatabaseUtil {
  DatabaseReference _counterRef;
  DatabaseReference _userRef;
  StreamSubscription<Event> _counterSubscription;
  StreamSubscription<Event> _messagesSubscription;

  FirebaseDatabase database = new FirebaseDatabase();
  int _counter;
  DatabaseError error;

  static final FirebaseDatabaseUtil _instance =
                                  new FirebaseDatabaseUtil.internal();

  FirebaseDatabaseUtil.internal();

  factory FirebaseDatabaseUtil() {
    return _instance;
  }

  void initState() {
    // Demonstrates configuring to the database using a file
    _counterRef = FirebaseDatabase.instance.reference().child('counter');
    // Demonstrates configuring the database directly

    _userRef = database.reference().child('user');
    database.reference().child('counter').once().then((DataSnapshot snapshot) {
      print('Connect to second database and read ${snapshot.value}');
    });
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    _counterRef.keepSynced(true);

    _counterSubscription = _counterRef.onValue.listen((Event event) {
      error = null;
      _counter = event.snapshot.value ?? 0;
    }, onError: (Object o) {
      error = o;
    });
  }

  DatabaseError getError() {
    return error;
  }

  int getCounter() {
    return _counter;
  }

  DatabaseReference getUser() {
    return _userRef;
  }

  addUser(User user) async {
    final TransactionResult transactionResult =
    await _counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;

      return mutableData;
    });

        if (transactionResult.committed) {
          _userRef.push().set(<String, String>{
            "name": "" + user.name,
            "age": "" + user.age,
            "email": "" + user.email,
            "mobile": "" + user.mobile,
          }).then((_) {
            print('Data  commit done.');
          });
        } else {
          print('Data not commit.');
          if (transactionResult.error != null) {
            print(transactionResult.error.message);
          }
        }
  }

  void deleteUser(User user) async {
    await _userRef.child(user.id).remove().then((_) {
      print('Data  committed.');
    });
  }

  void updateUser(User user) async {
    await _userRef.child(user.id).update({
      "name": "" + user.name,
      "age": "" + user.age,
      "email": "" + user.email,
      "mobile": "" + user.mobile,
    }).then((_) {
      print('Data  committed.');
    });
  }

  void dispose() {
    _messagesSubscription.cancel();
    _counterSubscription.cancel();
  }
}