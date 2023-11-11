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
        if (state is Loading) {
          return const _LoadingChallenge();
        } else if (state is Loaded) {
          // return Column(
          //   children: [
          //     Expanded(
          //         flex: 7,
          //         child: _displayChallengePrompt(context, challenge.prompt)),
          //     Expanded(
          //         flex: 2,
          //         child: _displayButtonsAndInfo(context, challenge.level, 1)),
          //     Expanded(
          //         flex: 5,
          //         child: _buildChallenge(
          //             context, challenge.solution, challenge.options)),
          //   ],
          // );
          return SafeArea(
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
                                style: AppTheme.themeData.textTheme.titleSmall!
                                    .copyWith(
                                        color: AppTheme.colorScheme.secondary),
                              ),
                              Text(
                                "Tentativa 1",
                                style: AppTheme.themeData.textTheme.titleSmall!
                                    .copyWith(
                                        color: AppTheme.colorScheme.secondary),
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
                                style: AppTheme.themeData.textTheme.titleLarge!
                                    .copyWith(
                                  color: AppTheme.colorScheme.primaryContainer,
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
                              state.challenge.options.length,
                              (index) => _PillContainer(
                                text: state.challenge.options[index],
                                backgroundColor:
                                    AppTheme.colorScheme.primaryContainer,
                                textColor: Colors.black,
                              ),
                            ),
                            // children: [_PillContainer(text: 'test')],
                          ),
                          const Spacer(),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _PillContainer(
                                text: 'Desistir',
                                backgroundColor: AppTheme.colorScheme.secondary,
                                textColor: Colors.white,
                              ),
                              _PillContainer(
                                text: 'Submeter',
                                backgroundColor: AppTheme.colorScheme.primary,
                                textColor: Colors.white,
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
                              state.challenge.options.length,
                              (index) {
                                return _PillContainer(
                                  text: state.challenge.options[index],
                                  backgroundColor: _calculateColor(index),
                                  textColor: Colors.black,
                                );
                              },
                            ),
                            // children: [_PillContainer(text: 'test')],
                          ),
                          const Spacer(),
                        ],
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
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor,
        ),
        child: Text(
          text,
          style: AppTheme.themeData.textTheme.labelLarge!
              .copyWith(color: textColor),
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
