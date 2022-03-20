import 'package:todo_app_myroshnykov/src/domain/entities/user/user.dart';

abstract class UserRepository {
  Future<User> getUserInfo();
}
