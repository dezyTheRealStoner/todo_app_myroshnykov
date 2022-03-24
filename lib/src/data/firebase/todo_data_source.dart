import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/logger/custom_logger.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

@LazySingleton()
class TodoDataSource {
  TodoDataSource(this._firebaseAuth);

  final firebase.FirebaseAuth _firebaseAuth;

  final CollectionReference _profilesCollection =
      FirebaseFirestore.instance.collection('profiles');

  final logger = getLogger('TodosDataSource');

  static const todosCollectionName = 'todos';

  Future<DocumentSnapshot> getTodo({
    required String todoId,
  }) async {
    final userId = _firebaseAuth.currentUser!.email;

    final todoSnapshot = await _profilesCollection
        .doc(userId)
        .collection(todosCollectionName)
        .doc(todoId)
        .get();

    return todoSnapshot;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCompletedTodo({
    required String id,
    required bool completed,
  }) async {
    final todoSnapshot = await _profilesCollection
        .doc(id)
        .collection(todosCollectionName)
        .where(FieldPath.fromString('completed'), isEqualTo: true)
        .get();

    return todoSnapshot;
  }

  Future<void> updateTodoData({
    required String todoId,
    required String title,
    required String description,
    required String todoType,
    required DateTime dateTime,
    required bool completed,
  }) async {
    final userId = _firebaseAuth.currentUser!.email;

    return await _profilesCollection
        .doc(userId)
        .collection(todosCollectionName)
        .doc(todoId)
        .set({
      'title': title,
      'description': description,
      'todoType': todoType,
      'dateTime': dateTime,
      'completed': completed,
    });
  }

  Future<void> removeTodo({required String id}) async {
    final userId = _firebaseAuth.currentUser!.email;

    return await _profilesCollection
        .doc(userId)
        .collection(todosCollectionName)
        .doc(id)
        .delete();
  }
}
