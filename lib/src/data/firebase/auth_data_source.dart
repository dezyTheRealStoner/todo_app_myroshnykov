import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/data/firebase/profile_data_source.dart';
import 'package:todo_app_myroshnykov/src//logger/custom_logger.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

const _defaultImage = 'https://cdn-icons-png.flaticon.com/512/64/64572.png';

@LazySingleton()
class AuthDataSource {
  AuthDataSource(
    this._firebaseAuth,
    this._profileDataSource,
  );

  final firebase.FirebaseAuth _firebaseAuth;
  final ProfileDataSource _profileDataSource;

  final logger = getLogger('AuthDataSource');

  bool isUserLogged() {
    final userId = _firebaseAuth.currentUser?.uid;
    logger.i(userId);

    return userId != null || userId == '';
  }

  Future<void> registerWithEmailAndPassword({
    required String email,
    required String name,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    _profileDataSource.updateProfileData(
      email: email,
      name: name,
      image: _defaultImage,
      completedTodos: 0,
      todoIds: [],
      theme: 'dark',
      language: 'en',
    );
  }

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logOut() {
    return _firebaseAuth.signOut();
  }
}
