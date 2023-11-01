import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenge.freezed.dart';
part 'challenge.g.dart';

@freezed
class Challenge with _$Challenge {
  const factory Challenge({
    required int id,
    required String prompt,
    required int level,
    required int coins,
    @Default([]) List<String> solution,
  }) = _Challenge;

  factory Challenge.fromJson(Map<String, Object?> json) =>
      _$ChallengeFromJson(json);
}
