import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/features/friends/data/repository/friends_repository.dart';
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
    on<InviteUser>(_onInviteUser);
    on<AcceptInvite>(_onAcceptInvite);
  }

  Future<FutureOr<void>> _onLoadUser(
      LoadUser event, Emitter<UserState> emit) async {
    if (state is! Loaded) {
      emit(const UserState.loading());
      try {
        var user = await GetIt.I<UserRepository>().getUser();
        await _loadUserData(user, emit);
      } catch (_) {
        emit(const UserState.errorLoading());
      }
    }
  }

  Future<FutureOr<void>> _onUpdateUser(
      UpdateUser event, Emitter<UserState> emit) async {
    try {
      await _loadUserData(event.user, emit);
    } catch (_) {
      emit(const UserState.errorLoading());
    }
  }

  Future<void> _loadUserData(User user, Emitter<UserState> emit) async {
    var friends = await GetIt.I<FriendsRepository>().getFriends();
    var inviteSenders = <User>[];
    var futures = <Future>[];

    for (var invite in user.invites) {
      var future = GetIt.I<UserRepository>().getUserById(invite.fromUserId);
      future.then((value) => inviteSenders.add(value));
      futures.add(future);
    }

    //We may need multiple requests to get the senders of all invites
    //We need to create the futures and then call them like this
    //so the requests are fired concurrently.
    await Future.wait(futures);

    emit(
      UserState.loaded(user, friends, inviteSenders),
    );
  }

  FutureOr<void> _onInviteUser(InviteUser event, Emitter<UserState> emit) {
    GetIt.I<FriendsRepository>().sendInvite(event.userId);
  }

  FutureOr<void> _onAcceptInvite(AcceptInvite event, Emitter<UserState> emit) {
    GetIt.I<FriendsRepository>().acceptInvite(event.inviteId);
    add(const LoadUser());
  }
}
