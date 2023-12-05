import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcc_hpw_hello_programming_world/features/user/domain/entities/user.dart';

part 'invite.freezed.dart';
part 'invite.g.dart';

@freezed
class Invite with _$Invite {
  const factory Invite({
    required String id,
    required String fromUserId,
    required String toUserId,
  }) = _Invite;

  factory Invite.fromJson(Map<String, Object?> json) => _$InviteFromJson(json);
}
