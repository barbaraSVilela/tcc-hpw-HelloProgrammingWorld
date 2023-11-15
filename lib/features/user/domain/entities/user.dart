import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcc_hpw_hello_programming_world/features/rewards/domain/entities/reward.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String name,
    required int streak,
    required int level,
    required int coins,
    @Default([]) List<Reward> rewards,
    @Default([]) List<User> users,
    @Default([]) List<String> invites,
    @Default({}) Map<DateTime, String> solvedChallenges,
    @Default({}) Map<DateTime, String> failedChallenges,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
