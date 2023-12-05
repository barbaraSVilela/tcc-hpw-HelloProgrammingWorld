part of 'user_bloc.dart';

@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.loadUser() = LoadUser;
  const factory UserEvent.loadRanking() = LoadRanking;
  const factory UserEvent.updateUser({required User user}) = UpdateUser;
  const factory UserEvent.inviteUser({required String userId}) = InviteUser;
  const factory UserEvent.acceptInvite({required String inviteId}) =
      AcceptInvite;
}
