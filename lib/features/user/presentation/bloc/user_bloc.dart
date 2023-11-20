import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/features/friends/domain/entities/invite.dart';
import 'package:tcc_hpw_hello_programming_world/features/user/data/repository/user_repository.dart';
import 'package:tcc_hpw_hello_programming_world/features/user/domain/entities/user.dart';

part 'user_event.dart';
part 'user_state.dart';
part 'user_bloc.freezed.dart';

class UserBloc extends Bloc<UserEvent, UserState>
    with BlocPresentationMixin<UserState, UserEvent> {
  UserBloc() : super(const UserState.loading()) {
    on<LoadUser>(_onLoadUser);
    on<UpdateUser>(_onUpdateUser);
  }

  Future<FutureOr<void>> _onLoadUser(
      LoadUser event, Emitter<UserState> emit) async {
    if (state is! Loaded) {
      emit(const UserState.loading());
      try {
        var user = await GetIt.I<UserRepository>().getUser();
        emit(
          UserState.loaded(
            user.copyWith(friends: [
              User(
                  id: 's',
                  email: 'a',
                  name: "João",
                  streak: 1,
                  level: 1,
                  coins: 1),
              User(
                  id: 's',
                  email: 'a',
                  name: "Maria",
                  streak: 2,
                  level: 2,
                  coins: 1),
              User(
                  id: 's',
                  email: 'a',
                  name: "José",
                  streak: 3,
                  level: 3,
                  coins: 1),
              User(
                  id: 's',
                  email: 'a',
                  name: "Carlos",
                  streak: 4,
                  level: 8,
                  coins: 1),
              User(
                  id: 's',
                  email: 'a',
                  name: "Manoel",
                  streak: 5,
                  level: 5,
                  coins: 1),
              User(
                  id: 's',
                  email: 'a',
                  name: "Paulo",
                  streak: 6,
                  level: 6,
                  coins: 1),
            ], invites: [
              Invite(
                  id: '',
                  sender: User(
                      id: '',
                      email: '',
                      name: '',
                      streak: 0,
                      level: 0,
                      coins: 0),
                  receiver: User(
                      id: '',
                      email: '',
                      name: 'Luís',
                      streak: 0,
                      level: 0,
                      coins: 0),
                  status: '')
            ]),
          ),
        );
      } catch (_) {
        emit(const UserState.errorLoading());
      }
    }
  }

  FutureOr<void> _onUpdateUser(UpdateUser event, Emitter<UserState> emit) {
    emit(UserState.loaded(event.user));
  }
}
