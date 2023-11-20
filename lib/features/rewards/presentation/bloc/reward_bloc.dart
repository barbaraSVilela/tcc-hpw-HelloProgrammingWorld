import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/features/rewards/data/repository/reward_repository.dart';
import 'package:tcc_hpw_hello_programming_world/features/rewards/domain/entities/reward.dart';

part 'reward_event.dart';
part 'reward_state.dart';
part 'reward_bloc.freezed.dart';

class RewardBloc extends Bloc<RewardEvent, RewardState> {
  RewardBloc() : super(const RewardState.loading()) {
    on<LoadRewards>(_onLoadRewards);
    on<PurchaseReward>(_onPurchaseReward);
  }

  Future<FutureOr<void>> _onLoadRewards(
      LoadRewards event, Emitter<RewardState> emit) async {
    if (state is! Loaded) {
      emit(const RewardState.loading());
      try {
        var rewards = await GetIt.I<RewardRepository>().getAvailableRewards();
        rewards.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
        emit(RewardState.loaded(rewards));
      } catch (_) {
        emit(const RewardState.errorLoading());
      }
    }
  }

  FutureOr<void> _onPurchaseReward(
      PurchaseReward event, Emitter<RewardState> emit) {}
}
