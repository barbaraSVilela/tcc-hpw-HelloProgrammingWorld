import 'dart:async';

import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/features/give_help/data/repository/give_help_repository.dart';

part 'give_help_event.dart';
part 'give_help_state.dart';
part 'give_help_bloc.freezed.dart';

class GiveHelpBloc extends Bloc<GiveHelpEvent, GiveHelpState>
    with BlocPresentationMixin<GiveHelpState, GiveHelpEvent> {
  GiveHelpBloc() : super(const _Initial()) {
    on<Submit>(onSubmit);
  }

  FutureOr<void> onSubmit(Submit event, Emitter<GiveHelpState> emit) {
    GetIt.I<GiveHelpRepository>().sendHelp(event.tip, event.challengeId);
    emitPresentation(const GiveHelpEvent.submitted());
  }
}
