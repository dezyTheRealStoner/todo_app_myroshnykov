import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/data/firebase/auth_data_source.dart';
import 'package:todo_app_myroshnykov/src/data/mappers/user_mapper.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/user/user.dart';
import 'package:todo_app_myroshnykov/src/domain/repositories/user_repository.dart';
import 'package:todo_app_myroshnykov/src/logger/custom_logger.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._authDataSource);

  final AuthDataSource _authDataSource;

  final logger = getLogger('UserRepositoryImpl');

  @override
  Future<User> getUserInfo() async {
    try {
      final userSnapshot = await _authDataSource.getUserInfo();

      final user = UserMapper().fromDocument(userSnapshot);

      return user;
    } on Exception catch (error) {
      logger.e(error);
      throw Exception();
    }
  }
}
