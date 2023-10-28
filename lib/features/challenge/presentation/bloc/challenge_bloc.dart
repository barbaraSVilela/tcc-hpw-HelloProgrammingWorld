import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenge_event.dart';
part 'challenge_state.dart';
part 'challenge_bloc.freezed.dart';

class ChallengeBloc extends Bloc<ChallengeEvent, ChallengeState> {
  ChallengeBloc() : super(const ChallengeState.initial()) {
    on<ChallengeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
