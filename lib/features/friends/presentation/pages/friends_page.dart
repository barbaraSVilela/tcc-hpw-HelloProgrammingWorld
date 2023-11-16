import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/config/themes/app_theme.dart';
import 'package:tcc_hpw_hello_programming_world/features/user/domain/entities/user.dart';
import 'package:tcc_hpw_hello_programming_world/features/user/presentation/bloc/user_bloc.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
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
            return const Center(child: _LoadingInfo());
          } else if (state is Loaded) {
            return SafeArea(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Amigos",
                              style: AppTheme.themeData.textTheme.titleLarge!
                                  .copyWith(
                                      color: AppTheme.colorScheme.primary)),
                          const SizedBox(height: 20),
                          Center(
                            child: Container(
                              color: AppTheme.colorScheme.primary,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (state.user.name.isNotEmpty)
                                    Text("Nome: ${state.user.name}",
                                        style: AppTheme
                                            .themeData.textTheme.titleMedium!
                                            .copyWith(
                                                color: AppTheme
                                                    .colorScheme.onPrimary)),
                                  Text("Email: ${state.user.email}",
                                      style: AppTheme
                                          .themeData.textTheme.titleMedium!
                                          .copyWith(
                                              color: AppTheme
                                                  .colorScheme.onPrimary)),
                                  Text("Nível: ${state.user.level}",
                                      style: AppTheme
                                          .themeData.textTheme.titleMedium!
                                          .copyWith(
                                              color: AppTheme
                                                  .colorScheme.onPrimary)),
                                  Text("Streak: ${state.user.streak}",
                                      style: AppTheme
                                          .themeData.textTheme.titleMedium!
                                          .copyWith(
                                              color: AppTheme
                                                  .colorScheme.onPrimary)),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      AppTheme.colorScheme.secondary,
                                      foregroundColor: AppTheme.colorScheme.onSecondary),
                                  child: const Text("Meu Código")),
                              ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      AppTheme.colorScheme.tertiary,
                                      foregroundColor: AppTheme.colorScheme.onTertiary),
                                  child: const Text("Enviar Convite"))
                            ],
                          ),ListView.builder(
                              itemCount: state.user.friends.length+1,
                              itemBuilder: (context, index){
                                List<User> rankingUsers = state.user.friends;
                                rankingUsers.add(state.user);
                              }
                          )

                        ])));
          } else {
            return const Center(child: _FailedLoad());
          }
        });
  }
}

class _LoadingInfo extends StatelessWidget {
  const _LoadingInfo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Informações do Usuário Carregando"),
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
