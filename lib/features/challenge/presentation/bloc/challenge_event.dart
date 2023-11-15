part of 'challenge_bloc.dart';

@freezed
class ChallengeEvent with _$ChallengeEvent {
  const factory ChallengeEvent.loadChallenge() = LoadChallenge;
  const factory ChallengeEvent.optionSelected(int index) = OptionSelected;
  const factory ChallengeEvent.optionRemovedFromSolution(int index) =
      OptionRemovedFromSolution;
  const factory ChallengeEvent.submitSolution() = SubmitSolution;
  const factory ChallengeEvent.attemptSuccessful() = AttemptSuccessful;
  const factory ChallengeEvent.attemptFailed({required int attemptsLeft}) =
      AttemptFailed;
  const factory ChallengeEvent.giveUp() = GiveUp;
}
