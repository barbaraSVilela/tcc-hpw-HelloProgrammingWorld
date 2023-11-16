import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/features/user/data/repository/user_repository.dart';
import 'package:tcc_hpw_hello_programming_world/features/user/domain/entities/user.dart';

part 'user_event.dart';
part 'user_state.dart';
part 'user_bloc.freezed.dart';


class UserBloc extends Bloc<UserEvent, UserState> with BlocPresentationMixin<UserState, UserEvent>{
  UserBloc() : super(const UserState.loading()) {
    on<LoadUser>(_onLoadUser);
  }

  Future<FutureOr<void>> _onLoadUser(
      LoadUser event, Emitter<UserState> emit) async {
    if (state is! Loaded) {
      emit(const UserState.loading());
      try {
        var user =
            await GetIt.I<UserRepository>().getUser();
        emit(UserState.loaded(user));
      } catch (_) {
        emit(const UserState.errorLoading());
      }
    }
  }
}

