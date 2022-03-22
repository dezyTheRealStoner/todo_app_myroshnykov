part of 'profile_cubit.dart';

@immutable
class ProfileState extends Equatable {
  const ProfileState({
    this.user = mockedUser,
    this.updating = false,
    this.openThemeButton = false,
    this.openLanguageButton = false,
    this.lightThemeSelected = false,
    this.darkThemeSelected = false,
    this.englishLanguageSelected = false,
    this.ukrainianLanguageSelected = false,
  });

  final User user;
  final bool updating;
  final bool openThemeButton;
  final bool openLanguageButton;
  final bool lightThemeSelected;
  final bool darkThemeSelected;
  final bool englishLanguageSelected;
  final bool ukrainianLanguageSelected;

  ProfileState copyWith({
    User? user,
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
        updating,
        openThemeButton,
        openLanguageButton,
        lightThemeSelected,
        darkThemeSelected,
        englishLanguageSelected,
        ukrainianLanguageSelected,
      ];
}
