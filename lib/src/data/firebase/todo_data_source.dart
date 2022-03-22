import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/logger/custom_logger.dart';

@LazySingleton()
class TodoDataSource {
  TodoDataSource();

  final logger = getLogger('TodosDataSource');

  final CollectionReference _todosCollection =
      FirebaseFirestore.instance.collection('todos');

  Future<DocumentSnapshot> getTodo({
    required String id,
  }) async {
    final todoSnapshot = await _todosCollection.doc(id).get();

    return todoSnapshot;
  }

  Future<void> updateTodoData({
    required String id,
    required String title,
    required String description,
    required String todoType,
    required DateTime dateTime,
    required bool completed,
  }) async {
    return await _todosCollection.doc(id).set({
      'title': title,
      'description': description,
      'todoType': todoType,
      'dateTime': dateTime,
      'completed': completed,
    });
  }

  Future<void> removeTodo({required String id}) async {
    return await _todosCollection.doc(id).delete();
  }
}
