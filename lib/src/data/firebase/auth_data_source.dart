import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/data/firebase/profile_data_source.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/user/user.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/logger/custom_logger.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

const _defaultImage =
    'https://www.mzchr.ru/wp-content/uploads/2021/09/avasite.png';

@LazySingleton()
class AuthDataSource {
  AuthDataSource(this._firebase);

  final logger = getLogger('AuthDataSource');

  final firebase.FirebaseAuth _firebase;

  bool isUserLogged() {
    final userId = _firebase.currentUser?.uid;
    logger.i(userId);

    return userId != null || userId == '';
  }

  Future<User> getUserInfo() async {
    final userEmail = _firebase.currentUser!.email;
    final user = await ProfileDataSource(id: userEmail!).getUserProfileData();

    return user;
  }

  Future<void> registerWithEmailAndPassword({
    required String email,
    required String name,
    required String password,
  }) async {
    await _firebase.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await ProfileDataSource(id: email).updateProfileData(
      email: email,
      name: name,
      image: _defaultImage,
      todoIds: [],
    );
  }

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebase.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logOut() {
    return _firebase.signOut();
  }
}
