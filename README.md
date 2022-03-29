# todo_app_myroshnykov

Run code generation:
```flutter packages pub run build_runner build --delete-conflicting-outputs```

Run localization keys generator:
```flutter pub run easy_localization:generate -f keys -o locale_keys.g.dart -S assets/translations -O lib/src/presentation/base/localization```