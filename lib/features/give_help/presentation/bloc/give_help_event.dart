part of 'give_help_bloc.dart';

@freezed
class GiveHelpEvent with _$GiveHelpEvent {
  const factory GiveHelpEvent.submit({
    required String challengeId,
    required String tip,
  }) = Submit;
  const factory GiveHelpEvent.submitted() = Submitted;
}
