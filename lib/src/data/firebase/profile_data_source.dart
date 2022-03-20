import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/user/user.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/logger/custom_logger.dart';

@LazySingleton()
class ProfileDataSource {
  ProfileDataSource({required this.id});

  final String id;

  final logger = getLogger('ProfileDataSource');

  final CollectionReference _profilesCollection =
      FirebaseFirestore.instance.collection('profiles');

  Future<User> getUserProfileData() async {
    final profile = await _profilesCollection.doc(id).get();

    final user = User.fromDocument(profile);

    return user;
  }

  Future<void> updateProfileData({
    required String email,
    required String name,
    required String image,
    required List<dynamic> todoIds,
  }) async {
    return await _profilesCollection.doc(id).set({
      'email': email,
      'name': name,
      'image': image,
      'todoIds': todoIds,
    });
  }
}
