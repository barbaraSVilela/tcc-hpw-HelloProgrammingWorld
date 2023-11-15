part of 'challenge_bloc.dart';

@freezed
class ChallengeState with _$ChallengeState {
  const factory ChallengeState.loading() = Loading;
  const factory ChallengeState.loaded({
    required Challenge challenge,
    @Default([]) List<String> selectedSolution,
    @Default([]) List<String?> availableOptions,
    required int attemptsLeft,
  }) = Loaded;
  const factory ChallengeState.errorLoading() = ErrorLoading;
  const factory ChallengeState.completed() = Completed;
  const factory ChallengeState.noMoreAttempts() = NoMoreAttempts;
}
