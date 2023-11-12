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
    on<OptionSelected>(_onOptionSelected);
    on<OptionRemovedFromSolution>(_onOptionRemovedFromSolution);
  }

  Future<FutureOr<void>> _onLoadChallenge(
      LoadChallenge event, Emitter<ChallengeState> emit) async {
    if (state is! Loaded) {
      emit(const ChallengeState.loading());
      try {
        var challenge =
            await GetIt.I<ChallengeRepository>().getDailyChallenge();
        emit(
          ChallengeState.loaded(
            challenge: challenge,
            availableOptions: List.from(challenge.options),
          ),
        );
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
}
