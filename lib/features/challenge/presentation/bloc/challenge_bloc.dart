import 'dart:async';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/data/repository/challenge_repository.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/domain/entity/challenge.dart';
import 'package:tcc_hpw_hello_programming_world/features/user/data/repository/user_repository.dart';

part 'challenge_event.dart';
part 'challenge_state.dart';
part 'challenge_bloc.freezed.dart';

class ChallengeBloc extends Bloc<ChallengeEvent, ChallengeState>
    with BlocPresentationMixin<ChallengeState, ChallengeEvent> {
  ChallengeBloc() : super(const ChallengeState.loading()) {
    on<LoadChallenge>(_onLoadChallenge);
    on<OptionSelected>(_onOptionSelected);
    on<OptionRemovedFromSolution>(_onOptionRemovedFromSolution);
    on<SubmitSolution>(_onSubmitSolution);
    on<GiveUp>(_onGiveUp);
  }

  int attempts = 3;

  Future<FutureOr<void>> _onLoadChallenge(
      LoadChallenge event, Emitter<ChallengeState> emit) async {
    if (state is! Loaded) {
      emit(const ChallengeState.loading());
      try {
        var challenge =
            await GetIt.I<ChallengeRepository>().getDailyChallenge();
        var currentUser = await GetIt.I<UserRepository>().getUser();
        var now = DateTime.now().toUtc();
        var today = DateTime.utc(now.year, now.month, now.day);
        if (currentUser.solvedChallenges.containsKey(today)) {
          emit(ChallengeState.completed(
            currentStreak: currentUser.streak,
            currentLevel: currentUser.level,
            challenge: challenge,
          ));
        } else if (currentUser.failedChallenges.containsKey(today)) {
          emit(ChallengeState.noMoreAttempts(challenge: challenge));
        } else {
          emit(
            ChallengeState.loaded(
              attemptsLeft: attempts,
              challenge: challenge,
              availableOptions: List.from(challenge.options),
            ),
          );
        }
      } catch (_) {
        emit(const ChallengeState.errorLoading());
      }
    }
  }

  FutureOr<void> _onOptionSelected(
      OptionSelected event, Emitter<ChallengeState> emit) {
    if (state is Loaded) {
      var loadedState = state as Loaded;
      var selectedOption = loadedState.availableOptions[event.index]!;
      var updatedSolution = List<String>.from(loadedState.selectedSolution)
        ..add(selectedOption);
      var updatedOptions = List<String>.from(loadedState.availableOptions)
        ..removeAt(event.index);
      emit(
        loadedState.copyWith(
          selectedSolution: updatedSolution,
          availableOptions: updatedOptions,
        ),
      );
    }
  }

  FutureOr<void> _onOptionRemovedFromSolution(
      OptionRemovedFromSolution event, Emitter<ChallengeState> emit) {
    if (state is Loaded) {
      var loadedState = state as Loaded;
      var removedOption = loadedState.selectedSolution[event.index]!;
      var updatedSolution = List<String>.from(loadedState.selectedSolution)
        ..removeAt(event.index);
      var updatedOptions = List<String>.from(loadedState.availableOptions)
        ..add(removedOption);
      emit(
        loadedState.copyWith(
          selectedSolution: updatedSolution,
          availableOptions: updatedOptions,
        ),
      );
    }
  }

  Future<FutureOr<void>> _onSubmitSolution(
      SubmitSolution event, Emitter<ChallengeState> emit) async {
    if (state is Loaded) {
      var loadedState = state as Loaded;
      var isCorrect = const ListEquality()
          .equals(loadedState.challenge.solution, loadedState.selectedSolution);

      emit(const ChallengeState.loading());
      var getUpdatedUser =
          GetIt.I<ChallengeRepository>().solveDailyChallenge(isCorrect);
      if (isCorrect) {
        emitPresentation(const ChallengeEvent.attemptSuccessful());
        var updatedUser = await getUpdatedUser;
        emit(ChallengeState.completed(
          currentLevel: updatedUser.level,
          currentStreak: updatedUser.streak,
          challenge: loadedState.challenge,
        ));
      } else {
        attempts--;
        emitPresentation(ChallengeEvent.attemptFailed(attemptsLeft: attempts));
        if (attempts <= 0) {
          try {
            await getUpdatedUser;
          } catch (_) {}
          emit(ChallengeState.noMoreAttempts(challenge: loadedState.challenge));
        } else {
          emit(loadedState.copyWith(attemptsLeft: attempts));
        }
      }
    }
  }

  FutureOr<void> _onGiveUp(GiveUp event, Emitter<ChallengeState> emit) {
    if (state is Loaded) {
      var loadedState = state as Loaded;
      emit(loadedState.copyWith(
        availableOptions: List.from(loadedState.availableOptions)
          ..addAll(loadedState.selectedSolution),
        selectedSolution: [],
      ));
    }
  }
}
