part of 'challenge_bloc.dart';

@freezed
class ChallengeState with _$ChallengeState {
  const factory ChallengeState.loading() = Loading;
  const factory ChallengeState.loaded(Challenge challenge) = Loaded;
  const factory ChallengeState.errorLoading() = ErrorLoading;
}
