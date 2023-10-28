part of 'challenge_bloc.dart';

@freezed
class ChallengeEvent with _$ChallengeEvent {
  const factory ChallengeEvent.started() = _Started;
}
