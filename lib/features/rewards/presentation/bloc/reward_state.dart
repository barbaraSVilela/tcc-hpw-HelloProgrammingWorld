part of 'reward_bloc.dart';

@freezed
class RewardState with _$RewardState {
  const factory RewardState.loading() = Loading;
  const factory RewardState.loaded(List<Reward> rewards) = Loaded;
  const factory RewardState.errorLoading() = ErrorLoading;
}
