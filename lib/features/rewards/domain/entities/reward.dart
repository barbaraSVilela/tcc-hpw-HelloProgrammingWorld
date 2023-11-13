import 'package:freezed_annotation/freezed_annotation.dart';
part 'reward.freezed.dart';
part 'reward.g.dart';
@freezed
class Reward with _$Reward {
  const factory Reward({
    required String id,
    required String title,
    required String description,
    required String image,
    required int price,
    required int sortOrder,
  }) = _Reward;

factory Reward.fromJson(Map<String, Object?> json) =>
      _$RewardFromJson(json);
}
