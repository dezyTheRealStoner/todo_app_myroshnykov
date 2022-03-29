import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/todo/todo.dart';

@injectable
class TodoMapper {
  Todo fromDocument(DocumentSnapshot doc) {
    return Todo(
      id: doc.id,
      title: doc.get('title'),
      description: doc.get('description'),
      dateTime: (doc.get('dateTime') as Timestamp).toDate(),
      todoType: doc.get('todoType'),
      completed: doc.get('completed'),
    );
  }
}
