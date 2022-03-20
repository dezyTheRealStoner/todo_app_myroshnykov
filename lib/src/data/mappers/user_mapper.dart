import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/user/user.dart';

@injectable
class UserMapper {
  User fromDocument(DocumentSnapshot doc) {
    return User(
      email: doc.get('email'),
      name: doc.get('name'),
      image: doc.get('image'),
      todoIds: doc.get('todoIds'),
    );
  }
}
