import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            var all = List<User>.from(state.friends)..add(state.user);
            all.sort(
              (a, b) => b.streak.compareTo(a.streak),
            );
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
                              decoration: BoxDecoration(
                                color: AppTheme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
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
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                  onPressed: () => _showMyCode(state.user.id),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          AppTheme.colorScheme.secondary,
                                      foregroundColor:
                                          AppTheme.colorScheme.onSecondary),
                                  child: const Text("Meu Código")),
                              ElevatedButton(
                                  onPressed: () => _showSendInviteDialog(),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          AppTheme.colorScheme.tertiary,
                                      foregroundColor:
                                          AppTheme.colorScheme.onTertiary),
                                  child: const Text("Enviar Convite"))
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text("Ranking",
                              style: AppTheme.themeData.textTheme.titleLarge!
                                  .copyWith(
                                      color: AppTheme.colorScheme.tertiary)),
                          const SizedBox(height: 20),
                          ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                    height: 1,
                                  ),
                              shrinkWrap: true,
                              itemCount: all.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(all[index].name,
                                        style: AppTheme
                                            .themeData.textTheme.titleMedium!
                                            .copyWith(
                                                color: AppTheme
                                                    .colorScheme.primary)),
                                    Text('${all[index].streak.toString()} dias',
                                        style: AppTheme
                                            .themeData.textTheme.titleMedium!
                                            .copyWith(
                                                color: AppTheme
                                                    .colorScheme.primary)),
                                  ],
                                );
                              }),
                          const SizedBox(height: 20),
                          Text("Convites pendentes",
                              style: AppTheme.themeData.textTheme.titleLarge!
                                  .copyWith(
                                      color: AppTheme.colorScheme.tertiary)),
                          const SizedBox(height: 20),
                          ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                    height: 1,
                                  ),
                              shrinkWrap: true,
                              itemCount: state.user.invites.length,
                              itemBuilder: (context, index) {
                                var sender = state.inviteSenders
                                    .where((a) =>
                                        a.id ==
                                        state.user.invites[index].fromUserId)
                                    .first;
                                return GestureDetector(
                                  onTap: () => _showAcceptDialog(sender.name,
                                      state.user.invites[index].id),
                                  child: Text(sender.name,
                                      style: AppTheme
                                          .themeData.textTheme.titleMedium!
                                          .copyWith(
                                              color: AppTheme
                                                  .colorScheme.primary)),
                                );
                              }),
                        ])));
          } else {
            return const Center(child: _FailedLoad());
          }
        });
  }

  Future<void> _showSendInviteDialog() async {
    var controller = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar amigo'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Código do amigo'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Enviar'),
              onPressed: () {
                _bloc.add(InviteUser(userId: controller.text));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyCode(String userId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Meu Código'),
          content: Text(userId),
          actions: <Widget>[
            TextButton(
              child: const Text('Copiar'),
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: userId));
              },
            ),
            TextButton(
              child: const Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAcceptDialog(String name, String inviteId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Aceitar convite'),
          content: Text('Deseja aceitar o convite de $name'),
          actions: <Widget>[
            TextButton(
              child: const Text('Sim'),
              onPressed: () async {
                _bloc.add(AcceptInvite(inviteId: inviteId));
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Não'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
