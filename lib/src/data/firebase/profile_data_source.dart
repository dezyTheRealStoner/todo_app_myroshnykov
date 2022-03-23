import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/logger/custom_logger.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

@LazySingleton()
class ProfileDataSource {
  ProfileDataSource(this._firebaseAuth);

  final firebase.FirebaseAuth _firebaseAuth;

  final CollectionReference _profilesCollection =
      FirebaseFirestore.instance.collection('profiles');

  final logger = getLogger('ProfileDataSource');

  Future<DocumentSnapshot> getUserProfileData() async {
    final userId = _firebaseAuth.currentUser!.email;

    final profileSnapshot = await _profilesCollection.doc(userId).get();

    return profileSnapshot;
  }

  Future<void> updateProfileData({
    required String email,
    required String name,
    required String image,
    required int completedTodos,
    required List<dynamic> todoIds,
    required String theme,
    required String language,
  }) async {
    final userId = _firebaseAuth.currentUser!.email;

    return await _profilesCollection.doc(userId).set({
      'email': email,
      'name': name,
      'image': image,
      'completedTodos': completedTodos,
      'todoIds': todoIds,
      'theme': theme,
      'language': language,
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllTodos() async {
    final userId = _firebaseAuth.currentUser!.email;

    final todosSnapshot =
        await _profilesCollection.doc(userId).collection('todos').get();

    return todosSnapshot;
  }
}
