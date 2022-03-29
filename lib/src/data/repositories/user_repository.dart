import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/data/firebase/profile_data_source.dart';
import 'package:todo_app_myroshnykov/src/data/mappers/user_mapper.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/user/user.dart';
import 'package:todo_app_myroshnykov/src/domain/repositories/user_repository.dart';
import 'package:todo_app_myroshnykov/src/logger/custom_logger.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(
    this._profileDataSource,
  );

  final ProfileDataSource _profileDataSource;

  final logger = getLogger('UserRepositoryImpl');

  @override
  Future<User> getUserInfo() async {
    try {
      final userSnapshot = await _profileDataSource.getUserProfileData();

      final user = UserMapper().fromDocument(userSnapshot);

      return user;
    } on Exception catch (error) {
      logger.e(error);
      throw Exception();
    }
  }

  @override
  Future<void> updateUserInfo(User user) async {
    try {
      await _profileDataSource.updateProfileData(
        email: user.email,
        name: user.name,
        image: user.image,
        todoIds: user.todoIds,
        theme: themeToString(user.theme),
        language: languageToString(user.language),
      );
    } on Exception catch (error) {
      logger.e(error);
      throw Exception();
    }
  }
}
