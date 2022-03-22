import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/logger/custom_logger.dart';

@LazySingleton()
class ProfileDataSource {
  ProfileDataSource();

  final logger = getLogger('ProfileDataSource');

  final CollectionReference _profilesCollection =
      FirebaseFirestore.instance.collection('profiles');

  Future<DocumentSnapshot> getUserProfileData(
    String id,
  ) async {
    final profileSnapshot = await _profilesCollection.doc(id).get();

    return profileSnapshot;
  }

  Future<void> updateProfileData({
    required String id,
    required String email,
    required String name,
    required String image,
    required List<dynamic> todoIds,
    required int completedTodos,
    required String theme,
    required String language,
  }) async {
    return await _profilesCollection.doc(id).set({
      'email': email,
      'name': name,
      'image': image,
      'todoIds': todoIds,
      'completedTodos': completedTodos,
      'theme': theme,
      'language': language,
    });
  }
}
