part of 'reward_bloc.dart';

@freezed
class RewardEvent with _$RewardEvent {
  const factory RewardEvent.loadRewards() = LoadRewards;
  const factory RewardEvent.purchaseReward() = PurchaseReward;
}
