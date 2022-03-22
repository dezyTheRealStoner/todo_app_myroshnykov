import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/personalization/user_language.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/personalization/user_theme.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/user/user.dart';

@injectable
class UserMapper {
  User fromDocument(DocumentSnapshot doc) {
    return User(
      email: doc.get('email'),
      name: doc.get('name'),
      image: doc.get('image'),
      todoIds: doc.get('todoIds'),
      completedTodos: doc.get('completedTodos'),
      theme: stringToTheme(doc.get('theme')),
      language: stringToLanguage(doc.get('language')),
    );
  }
}

@injectable
UserTheme stringToTheme(String stringFromDoc) {
  if (stringFromDoc == 'light') {
    return UserTheme.light;
  } else {
    return UserTheme.dark;
  }
}

@injectable
UserLanguage stringToLanguage(String stringFromDoc) {
  if (stringFromDoc == 'en') {
    return UserLanguage.en;
  } else {
    return UserLanguage.uk;
  }
}

@injectable
String themeToString(UserTheme userTheme) {
  if (userTheme == UserTheme.light) {
    return 'light';
  } else {
    return 'dark';
  }
}

@injectable
String languageToString(UserLanguage userLanguage) {
  if (userLanguage == UserLanguage.en) {
    return 'en';
  } else {
    return 'uk';
  }
}
