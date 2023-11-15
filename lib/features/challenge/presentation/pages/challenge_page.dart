import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/config/themes/app_theme.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/presentation/bloc/challenge_bloc.dart';
import 'package:tcc_hpw_hello_programming_world/foundation/hpw_colors.dart';

class ChallengePage extends StatefulWidget {
  const ChallengePage({super.key});

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  late ChallengeBloc _bloc;
  @override
  void initState() {
    _bloc = GetIt.I<ChallengeBloc>();

    _bloc.add(const ChallengeEvent.loadChallenge());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: BlocBuilder<ChallengeBloc, ChallengeState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state is Completed) {
          return _CompletedChallenge(
            level: state.currentLevel,
            streak: state.currentStreak,
          );
        } else if (state is NoMoreAttempts) {
          return const _OutOfAttempts();
        } else if (state is Loading) {
          return const _LoadingChallenge();
        } else if (state is Loaded) {
          return BlocPresentationListener<ChallengeBloc, ChallengeEvent>(
            bloc: _bloc,
            listener: (context, event) {
              if (event is AttemptSuccessful) {
                _showSuccessDialog();
              }
              if (event is AttemptFailed) {
                _showFailedDialog(event.attemptsLeft);
              }
            },
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            const SizedBox(height: 5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Nível ${state.challenge.level}",
                                  style: AppTheme
                                      .themeData.textTheme.titleSmall!
                                      .copyWith(
                                          color:
                                              AppTheme.colorScheme.secondary),
                                ),
                                Text(
                                  "${state.attemptsLeft} tentativas restantes",
                                  style: AppTheme
                                      .themeData.textTheme.titleSmall!
                                      .copyWith(
                                          color:
                                              AppTheme.colorScheme.secondary),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Container(
                              decoration: BoxDecoration(
                                color: AppTheme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  state.challenge.prompt,
                                  textAlign: TextAlign.center,
                                  style: AppTheme
                                      .themeData.textTheme.titleLarge!
                                      .copyWith(
                                    color:
                                        AppTheme.colorScheme.primaryContainer,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              direction: Axis.horizontal,
                              children: List.generate(
                                state.selectedSolution.length,
                                (index) => _PillContainer(
                                  text: state.selectedSolution[index],
                                  backgroundColor:
                                      AppTheme.colorScheme.primaryContainer,
                                  textColor: Colors.black,
                                  onTap: () => _bloc
                                      .add(OptionRemovedFromSolution(index)),
                                ),
                              ),
                            ),
                            const Spacer(),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _PillContainer(
                                  text: 'Desistir',
                                  backgroundColor:
                                      AppTheme.colorScheme.secondary,
                                  textColor: Colors.white,
                                  onTap: () =>
                                      _bloc.add(const ChallengeEvent.giveUp()),
                                ),
                                _PillContainer(
                                  text: 'Submeter',
                                  backgroundColor: AppTheme.colorScheme.primary,
                                  textColor: Colors.white,
                                  onTap: () => _bloc.add(
                                      const ChallengeEvent.submitSolution()),
                                )
                              ],
                            ),
                            const Divider(thickness: 2),
                            const SizedBox(height: 20),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              direction: Axis.horizontal,
                              children: List.generate(
                                state.availableOptions.length,
                                (index) {
                                  if (state.availableOptions[index] == null ||
                                      state.availableOptions[index]!.isEmpty) {
                                    //Display nothing
                                    return const SizedBox.shrink();
                                  } else {
                                    return _PillContainer(
                                      text: state.availableOptions[index]!,
                                      backgroundColor: _calculateColor(index),
                                      textColor: Colors.black,
                                      onTap: () =>
                                          _bloc.add(OptionSelected(index)),
                                    );
                                  }
                                },
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return const _FailedLoad();
        }
      },
    ));
  }

  Color _calculateColor(int index) {
    if (index % 3 == 0) {
      return HpwColors.pink;
    } else if (index % 3 == 1) {
      return HpwColors.green;
    } else if (index % 3 == 2) {
      return HpwColors.yellow;
    }
    return AppTheme.colorScheme.primaryContainer;
  }

  Future<void> _showSuccessDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Successo!'),
          content: const SingleChildScrollView(
            child: Text('Sua solução está correta!'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showFailedDialog(int attemptsLeft) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro!'),
          content: SingleChildScrollView(
            child: Text(
                'Sua solução está incorreta. Você tem $attemptsLeft restantes.'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
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

class _PillContainer extends StatelessWidget {
  const _PillContainer({
    required this.text,
    this.onTap,
    required this.backgroundColor,
    required this.textColor,
  });

  final String text;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 50,
        ),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppTheme.themeData.textTheme.labelLarge!.copyWith(
            color: textColor,
          ),
        ),
      ),
    );
  }
}

class _LoadingChallenge extends StatelessWidget {
  const _LoadingChallenge();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Desafio Carregando"),
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
          "Erro ao carregar o desafio.",
          style: TextStyle(color: AppTheme.colorScheme.error),
        ));
  }
}

class _CompletedChallenge extends StatelessWidget {
  const _CompletedChallenge({required this.level, required this.streak});

  final int level;
  final int streak;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Parabéns! Você concluiu o desafio de hoje!",
                style: AppTheme.themeData.textTheme.titleLarge!
                    .copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Text(
                "Você agora está no nível $level.",
                style: AppTheme.themeData.textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "Sua sequência atual é de $streak dias.",
                style: AppTheme.themeData.textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "Ajude outros estudantes dando dicas de estudo sobre este desafio.",
                style: AppTheme.themeData.textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              _PillContainer(
                text: 'Ajudar!',
                backgroundColor: AppTheme.colorScheme.primaryContainer,
                textColor: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _OutOfAttempts extends StatelessWidget {
  const _OutOfAttempts();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Que pena! Infelizmente, você não conseguiu solucionar o desafio de hoje. Volte amanhã!",
                style: AppTheme.themeData.textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "Veja dicas de estudo pertinentes ao desafio hoje.",
                style: AppTheme.themeData.textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              _PillContainer(
                text: 'Quero ajuda!',
                backgroundColor: AppTheme.colorScheme.primaryContainer,
                textColor: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
