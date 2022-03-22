import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/data/firebase/profile_data_source.dart';
import 'package:todo_app_myroshnykov/src//logger/custom_logger.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

const _defaultImage = 'https://cdn-icons-png.flaticon.com/512/64/64572.png';

@LazySingleton()
class AuthDataSource {
  AuthDataSource(
    this._firebase,
    this._profileDataSource,
  );

  final logger = getLogger('AuthDataSource');

  final firebase.FirebaseAuth _firebase;
  final ProfileDataSource _profileDataSource;

  bool isUserLogged() {
    final userId = _firebase.currentUser?.uid;
    logger.i(userId);

    return userId != null || userId == '';
  }

  Future<DocumentSnapshot> getUserInfo() async {
    final userEmail = _firebase.currentUser!.email;
    final userSnapshot =
        await _profileDataSource.getUserProfileData(userEmail!);

    return userSnapshot;
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

    _profileDataSource.updateProfileData(
      id: email,
      email: email,
      name: name,
      image: _defaultImage,
      todoIds: [],
      completedTodos: 0,
      theme: 'dark',
      language: 'en',
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
