import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/data/repository/challenge_repository.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/domain/entity/challenge.dart';

part 'challenge_event.dart';
part 'challenge_state.dart';
part 'challenge_bloc.freezed.dart';

class ChallengeBloc extends Bloc<ChallengeEvent, ChallengeState> {
  ChallengeBloc() : super(const ChallengeState.loading()) {
    on<LoadChallenge>(_onLoadChallenge);
  }

  Future<FutureOr<void>> _onLoadChallenge(
      LoadChallenge event, Emitter<ChallengeState> emit) async {
    if (state is! Loaded) {
      emit(const ChallengeState.loading());
      try {
        var challenge =
            await GetIt.I<ChallengeRepository>().getDailyChallenge();
        emit(ChallengeState.loaded(challenge));
      } catch (_) {
        emit(const ChallengeState.errorLoading());
      }
    }
  }
}
