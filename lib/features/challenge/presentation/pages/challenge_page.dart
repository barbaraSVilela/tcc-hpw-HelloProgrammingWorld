import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/config/themes/app_theme.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/domain/entity/challenge.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/presentation/bloc/challenge_bloc.dart';

class ChallengePage extends StatefulWidget {
  const ChallengePage({super.key});

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  late ChallengeBloc _bloc;
  final List<String> _selectedOptions = [];
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
          Challenge challenge = state.challenge;
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Nível ${state.challenge.level}",
                          style: AppTheme.themeData.textTheme.titleSmall!
                              .copyWith(color: AppTheme.colorScheme.secondary),
                        ),
                        Text(
                          "Tentativa 1",
                          style: AppTheme.themeData.textTheme.titleSmall!
                              .copyWith(color: AppTheme.colorScheme.secondary),
                        ),
                      ],
                    ),
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
                          style:
                              AppTheme.themeData.textTheme.titleLarge!.copyWith(
                            color: AppTheme.colorScheme.primaryContainer,
                          ),
                        ),
                      ),
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      children: List.generate(
                        state.challenge.options.length,
                        (index) => _PillContainer(
                          text: state.challenge.options[index],
                        ),
                      ),
                      // children: [_PillContainer(text: 'test')],
                    ),
                    const Divider(thickness: 2),
                  ],
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

  Widget _displayChallengePrompt(BuildContext context, String challengePrompt) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Card(
            elevation: 10,
            color: AppTheme.colorScheme.primary,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: AppTheme.colorScheme.outline),
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text("DESAFIO",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppTheme.colorScheme.onPrimary)),
                    SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Text(challengePrompt,
                          style: TextStyle(
                              color: AppTheme.colorScheme.onPrimary,
                              fontSize: 16),
                          textAlign: TextAlign.justify),
                    )
                  ],
                ))));
  }

  Widget _displayChallenge(BuildContext context, List<String> solution) {
    return GridView.count(
      crossAxisCount: 8,
      padding: const EdgeInsets.all(8.0),
      children: _transformAttempt(),
    );
  }

  void _onItemTappedRemove(String item) {
    setState(() {
      _selectedOptions.remove(item);
    });
  }

  Widget _attempt(String data) {
    return GestureDetector(
        onTap: () {
          _onItemTappedRemove(data);
        },
        child: Container(
          color: AppTheme.colorScheme.secondary,
          padding: const EdgeInsets.all(10),
          child: Text(data,
              style: TextStyle(color: AppTheme.colorScheme.onSecondary)),
        ));
  }

  List<Widget> _transformAttempt() {
    List<Widget> attempts = [];
    attempts = _selectedOptions.map((String e) => _attempt(e)).toList();
    return attempts;
  }

  Widget _displayButtonsAndInfo(BuildContext context, int level, int attempt) {
    return Container(
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const ElevatedButton(onPressed: null, child: Text("Run")),
          Text("Nível: $level"),
          Text("Tentativa: $attempt"),
          const ElevatedButton(onPressed: null, child: Text("Desistir"))
        ],
      ),
    );
  }

  Widget _buildChallenge(
      BuildContext context, List<String> solution, List<String> options) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _displayChallenge(context, solution),
          _displayOptions(context, options)
        ],
      ),
    );
  }

  Widget _displayOptions(BuildContext context, List<String> options) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Container(
                color: AppTheme.colorScheme.tertiary,
                child: Text(options[index],
                    style: TextStyle(color: AppTheme.colorScheme.onTertiary))),
            onTap: () {
              _onTappedAdd(options[index]);
            },
          );
        });
  }

  void _onTappedAdd(String data) {
    setState(() {
      _selectedOptions.add(data);
    });
  }
}

class _PillContainer extends StatelessWidget {
  const _PillContainer({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppTheme.colorScheme.primaryContainer,
      ),
      child: Text(
        text,
        style: AppTheme.themeData.textTheme.labelLarge,
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
