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
  @override
  void initState() {
    _bloc = GetIt.I<ChallengeBloc>();

    _bloc.add(const ChallengeEvent.loadChallenge());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: BlocBuilder<ChallengeBloc, ChallengeState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state is Loading) {
          return Padding(
              padding: EdgeInsets.all(100),
              child: Column(
                children: [
                  Text("Desafio Carregando"),
                  CircularProgressIndicator()
                ],
              ));
        } else if (state is Loaded) {
          Challenge _challenge = state.challenge;
          return Column(
            children: [
              Expanded(
                  child: _displayChallengePrompt(context, _challenge.prompt),
                  flex: 3),
              Expanded(
                  child: _displayChallenge(context, _challenge.solution),
                  flex: 6),
              Expanded(
                  child: _displayButtonsAndInfo(context, _challenge.level, 1),
                  flex: 1),
              Expanded(
                  child: _displayOptions(context, _challenge.options), flex: 3)
            ],
          );
        } else {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Error loading challenge",
                style: TextStyle(color: AppTheme.colorScheme.error),
              ));
        }
      },
    ));
  }

  Widget _displayChallengePrompt(BuildContext context, String challengePrompt) {
    return Container(
            padding: EdgeInsets.symmetric(vertical: 50),
            alignment: Alignment.center,
            child: Column(
              children: [
                Text("DESAFIO", style: TextStyle(fontWeight: FontWeight.bold)),
                SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Text(challengePrompt),
                )
              ],
            ));
  }

  Widget _displayChallenge(BuildContext context, List<String> solution) {
    return GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 80.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0),
            padding: const EdgeInsets.all(8.0),
            itemCount: solution.length,
            itemBuilder: (context, index) {
              return Container(
                  child: _buildOptionWithDropZone(solution[index]));
            });
  }

  Widget _buildOptionWithDropZone(String option) {
    return Expanded(
        child: DragTarget(builder: (context, candidateOption, rejectedOption) {
      return ColoredBox(color: AppTheme.colorScheme.secondary);
    }));
  }

  Widget _displayButtonsAndInfo(BuildContext context, int level, int attempt) {
    return Container(
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(onPressed: null, child: Text("Run")),
          Text("Nível: $level"),
          Text("Tentativa: $attempt"),
          ElevatedButton(onPressed: null, child: Text("Desistir"))
        ],
      ),
    );
  }

  Widget _displayOptions(BuildContext context, List<String> options) {
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: options.length,
            itemBuilder: (context, index) {
              return Center(
                  child: LongPressDraggable<String>(
                      data: options[index],
                      feedback: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: AppTheme.colorScheme.primary),
                          alignment: Alignment.center,
                          child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(options[index],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)))),
                      childWhenDragging: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: AppTheme.colorScheme.tertiary),
                          alignment: Alignment.center,
                          child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(options[index]))),
                      child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: AppTheme.colorScheme.secondaryContainer),
                          alignment: Alignment.center,
                          child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(options[index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold))))));
            });
  }
}
