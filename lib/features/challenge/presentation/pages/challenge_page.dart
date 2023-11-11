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
          return const Padding(
              padding: EdgeInsets.all(100),
              child: Column(
                children: [
                  Text("Desafio Carregando"),
                  CircularProgressIndicator()
                ],
              ));
        } else if (state is Loaded) {
          Challenge challenge = state.challenge;
          return Column(
            children: [
              Expanded(
                  flex: 7,
                  child: _displayChallengePrompt(context, challenge.prompt)),
              Expanded(
                  flex: 2,
                  child: _displayButtonsAndInfo(context, challenge.level, 1)),
              Expanded(
                  flex: 5,
                  child: _buildChallenge(
                      context, challenge.solution, challenge.options)),
            ],
          );
        } else {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Error loading challenge",
                style: TextStyle(color: AppTheme.colorScheme.error),
              ));
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
