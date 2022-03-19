import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/logger/custom_logger.dart';

@LazySingleton()
class ProfileDataSource {
  ProfileDataSource({required this.id});

  final String id;

  final logger = getLogger('Database');

  final CollectionReference _profilesCollection =
      FirebaseFirestore.instance.collection('profiles');

  Future<void> updateProfileData({
    required String email,
    required String name,
    required String image,
    required List<String> todoIds,
  }) async {
    return await _profilesCollection.doc(id).set({
      'email': email,
      'name': name,
      'image': image,
      'todos': todoIds,
    });
  }
}
