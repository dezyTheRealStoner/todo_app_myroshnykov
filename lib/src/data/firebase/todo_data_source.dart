import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/logger/custom_logger.dart';

@LazySingleton()
class TodoDataSource {
  TodoDataSource({required this.id});

  final String id;

  final logger = getLogger('TodosDataSource');

  final CollectionReference _profilesCollection =
      FirebaseFirestore.instance.collection('todos');

  Future<void> updateTodoData({
    required String title,
    required String description,
    required String todoType,
    required DateTime dateTime,
    required bool completed,
  }) async {
    return await _profilesCollection.doc(id).set({
      'title': title,
      'description': description,
      'todoType': todoType,
      'dateTime': dateTime,
      'completed': completed,
    });
  }
}
