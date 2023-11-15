import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/config/themes/app_theme.dart';
import 'package:tcc_hpw_hello_programming_world/features/rewards/domain/entities/reward.dart';
import 'package:tcc_hpw_hello_programming_world/features/rewards/presentation/bloc/reward_bloc.dart';
import 'package:tcc_hpw_hello_programming_world/features/user/presentation/bloc/user_bloc.dart' as userBloc;

class RewardsPage extends StatefulWidget {
  const RewardsPage({super.key});

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  late RewardBloc _bloc;
  late userBloc.UserBloc _userBloc;
  @override
  void initState() {
    _bloc = GetIt.I<RewardBloc>();
    _bloc.add(const RewardEvent.loadRewards());
    _userBloc = GetIt.I<userBloc.UserBloc>();
    _userBloc.add(const userBloc.UserEvent.loadUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RewardBloc, RewardState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is Loading) {
            return Scaffold(body:Center(child: _Loading()));
          } else if (state is Loaded) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: AppTheme.colorScheme.surface,
                  foregroundColor: AppTheme.colorScheme.onSurface,
                  centerTitle: true,
                  title: Text("LOJA"),
                  leading: BackButton(onPressed: () => Navigator.pop(context)),
                  actions: [FittedBox(
                    fit: BoxFit.scaleDown,
                    child: _userCoins(context),
                  ),const Icon(Icons.add_business_outlined)],
                ),
                body: ListView.builder(
                    itemCount: state.rewards.length,
                    itemBuilder: (context, index) {
                      Reward currentReward = state.rewards[index];
                      return ListTile(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3),side: BorderSide(color: Colors.black)),
                          tileColor: AppTheme.colorScheme.primaryContainer,
                          contentPadding: EdgeInsets.all(10) ,
                          leading: Image.network(currentReward.image ),
                          title: Text(currentReward.title,style:  AppTheme.themeData.textTheme.titleSmall!.copyWith(
                              color: AppTheme.colorScheme.primary)),
                          subtitle:Text(currentReward.description,textAlign: TextAlign.justify),
                          trailing: FilledButton(
                            style: FilledButton.styleFrom(foregroundColor: AppTheme.colorScheme.onSecondary,backgroundColor: AppTheme.colorScheme.secondary),
                            onPressed: () => {},
                            child:  Text("\$" + currentReward.price.toString())
                          )
                      );
                    }));
          } else {
            return Scaffold(body: Center(child: _FailedLoad()));
          }
        });
  }
Widget _userCoins(BuildContext context){
return BlocBuilder<userBloc.UserBloc,userBloc.UserState>(
  bloc: _userBloc,
    builder: (context,state){
      if(state is userBloc.Loading){
        return  Text("Informação do usuário carregando");
      }else if(state is userBloc.Loaded){
            return Text("punched cards: " + state.user.coins.toString());
      }else{
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Erro ao carregar informação do usuário.",
              style: TextStyle(color: AppTheme.colorScheme.error),
            ));
      }
    });

}


}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Recompensas Carregando"),
        SizedBox(height: 20),
        CircularProgressIndicator(),
      ],
    );
  }
}

class _FailedLoad extends StatelessWidget {
  const _FailedLoad();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          "Erro ao carregar as recompensas.",
          style: TextStyle(color: AppTheme.colorScheme.error),
        ));
  }
}


