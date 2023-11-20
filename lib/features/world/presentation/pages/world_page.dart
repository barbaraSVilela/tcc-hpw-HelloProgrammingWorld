import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/config/themes/app_theme.dart';
import 'package:tcc_hpw_hello_programming_world/features/authentication/domain/bloc/authentication_bloc.dart';
import 'package:tcc_hpw_hello_programming_world/features/navigation/navigation_routes.dart';
import 'package:tcc_hpw_hello_programming_world/features/rewards/domain/entities/reward.dart';
import 'package:tcc_hpw_hello_programming_world/features/user/presentation/bloc/user_bloc.dart';

class WorldPage extends StatefulWidget {
  const WorldPage({super.key});

  @override
  State<WorldPage> createState() => _WorldPageState();
}

class _WorldPageState extends State<WorldPage> {
  late UserBloc _bloc;

  @override
  void initState() {
    _bloc = GetIt.I<UserBloc>();
    _bloc.add(const UserEvent.loadUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: _LoadingWorld());
          } else if (state is Loaded) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: LayoutBuilder(builder: (context, constraints) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _store(context),
                            const SizedBox(height: 20),
                            Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppTheme.colorScheme.primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      direction: Axis.horizontal,
                                      children: [
                                        if (state.user.rewards.isEmpty)
                                          Text("Mundo Ainda Vazio",
                                              style: AppTheme.themeData
                                                  .textTheme.titleLarge!
                                                  .copyWith(
                                                      color: Colors.white))
                                        else
                                          ...List.generate(
                                              state.user.rewards.length,
                                              (index) => SizedBox(
                                                    height: 60,
                                                    width: 60,
                                                    child: Image.network(
                                                      state.user.rewards[index]
                                                          .image,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ))
                                      ]),
                                )),
                            const SizedBox(height: 50),
                            Text(
                              "Minhas Recompensas",
                              style: AppTheme.themeData.textTheme.titleLarge!
                                  .copyWith(
                                      color: AppTheme.colorScheme.tertiary),
                            ),
                            const SizedBox(height: 20),
                            if (state.user.rewards.isEmpty)
                              Text("Recompensas ainda não foram compradas",
                                  style: AppTheme
                                      .themeData.textTheme.titleSmall!
                                      .copyWith(
                                          color: AppTheme
                                              .colorScheme.inverseSurface))
                            else
                              ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 5,
                                      ),
                                  shrinkWrap: true,
                                  itemCount: state.user.rewards.length,
                                  itemBuilder: (context, index) {
                                    Reward currentReward =
                                        state.user.rewards[index];
                                    return ListTile(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            side: const BorderSide(
                                                color: Colors.black)),
                                        tileColor: AppTheme
                                            .colorScheme.primaryContainer,
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        leading:
                                            Image.network(currentReward.image),
                                        title: Text(currentReward.title,
                                            style: AppTheme
                                                .themeData.textTheme.titleSmall!
                                                .copyWith(
                                                    color: AppTheme
                                                        .colorScheme.primary)),
                                        subtitle: Text(
                                            currentReward.description,
                                            textAlign: TextAlign.justify));
                                  })
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            );
          } else {
            return const Center(child: _FailedLoad());
          }
        });
  }

  Widget _store(BuildContext context) {
    return Row(
      children: [
        Text(
          "Meu Mundo",
          style: AppTheme.themeData.textTheme.titleLarge!
              .copyWith(color: AppTheme.colorScheme.primary),
        ),
        const Spacer(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.colorScheme.secondary,
              foregroundColor: AppTheme.colorScheme.onSecondary,
              textStyle: AppTheme.themeData.textTheme.labelLarge),
          onPressed: () async {
            Navigator.of(context).pop();
            GetIt.I<AuthenticationBloc>()
                .add(const AuthenticationEvent.signOut());
          },
          child: const Text("Sair"),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.colorScheme.secondary,
              foregroundColor: AppTheme.colorScheme.onSecondary,
              textStyle: AppTheme.themeData.textTheme.labelLarge),
          onPressed: () async {
            Navigator.push(context, NavigationRoutes.rewardsPageRoute.call());
          },
          child: const Text("Loja"),
        )
      ],
    );
  }
}

class _LoadingWorld extends StatelessWidget {
  const _LoadingWorld();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Mundo Carregando"),
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
          "Erro ao carregar informações do usuário.",
          style: TextStyle(color: AppTheme.colorScheme.error),
        ));
  }
}
