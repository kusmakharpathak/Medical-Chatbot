import 'package:firebase_database/firebase_database.dart';

class FirebaseServices {
  var ref = FirebaseDatabase.instance.reference();

  void insert(String collection, String id, Map<String, dynamic> data) {
    ref.child(collection).child(id).set(data);
  }

  read(String collection) {
    return ref.child(collection);
  }

  void update(String collection, String id, Map<String, dynamic> data) {
    ref.child(collection).child(id).update(data);
  }

  void remove(String collection, String id) {
    ref.child(collection).child(id).remove();
  }

  readSingle(String collection, String id) {
    return ref.child(collection).child(id);
  }
}
