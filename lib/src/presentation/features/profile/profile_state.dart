part of 'profile_cubit.dart';

@immutable
class ProfileState extends Equatable {
  const ProfileState({
    this.user = mockedUser,
    this.completedTodos = 0,
    this.updating = false,
    this.openThemeButton = false,
    this.openLanguageButton = false,
    this.lightThemeSelected = false,
    this.darkThemeSelected = false,
    this.englishLanguageSelected = false,
    this.ukrainianLanguageSelected = false,
  });

  final User user;
  final int completedTodos;
  final bool updating;
  final bool openThemeButton;
  final bool openLanguageButton;
  final bool lightThemeSelected;
  final bool darkThemeSelected;
  final bool englishLanguageSelected;
  final bool ukrainianLanguageSelected;

  ProfileState copyWith({
    User? user,
    int? completedTodos,
    bool? updating,
    bool? openThemeButton,
    bool? openLanguageButton,
    bool? lightThemeSelected,
    bool? darkThemeSelected,
    bool? englishLanguageSelected,
    bool? ukrainianLanguageSelected,
  }) {
    return ProfileState(
      user: user ?? this.user,
      completedTodos: completedTodos ?? this.completedTodos,
      updating: updating ?? this.updating,
      openThemeButton: openThemeButton ?? this.openThemeButton,
      openLanguageButton: openLanguageButton ?? this.openLanguageButton,
      lightThemeSelected: lightThemeSelected ?? this.lightThemeSelected,
      darkThemeSelected: darkThemeSelected ?? this.darkThemeSelected,
      englishLanguageSelected:
          englishLanguageSelected ?? this.englishLanguageSelected,
      ukrainianLanguageSelected:
          ukrainianLanguageSelected ?? this.ukrainianLanguageSelected,
    );
  }

  @override
  List<Object?> get props => [
        user,
        completedTodos,
        updating,
        openThemeButton,
        openLanguageButton,
        lightThemeSelected,
        darkThemeSelected,
        englishLanguageSelected,
        ukrainianLanguageSelected,
      ];
}
