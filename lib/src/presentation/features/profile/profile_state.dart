part of 'profile_cubit.dart';

@immutable
class ProfileState extends Equatable {
  const ProfileState({
    this.user = mockedUser,
    this.updating = false,
  });

  final User user;
  final bool updating;

  ProfileState copyWith({
    User? user,
    bool? updating,
  }) {
    return ProfileState(
      user: user ?? this.user,
      updating: updating ?? this.updating,
    );
  }

  @override
  List<Object?> get props => [
        user,
        updating,
      ];
}
