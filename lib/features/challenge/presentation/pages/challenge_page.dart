import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/config/themes/app_theme.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/presentation/bloc/challenge_bloc.dart';

class ChallengePage extends StatefulWidget {
  const ChallengePage({super.key});

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  bool selected = false;
  late ChallengeBloc _bloc;
  @override
  void initState() {
    _bloc = GetIt.I<ChallengeBloc>();
    super.initState();
  }

  final List<Widget> _challengeSpaces = [
    Container(
        color: const Color(0xFFB82000),
        child: DragTarget(
            builder: (context, cadidateData, rejectedData) {
                return const Text('TESTE');
    })
    ),
    Container(
        color: const Color(0xFFB82000),
        child: DragTarget(
            builder: (context, cadidateData, rejectedData) {
              return const Text('TESTE');
            })
    ),
    Container(
        color: const Color(0xFFB82000),
        child: DragTarget(
            builder: (context, cadidateData, rejectedData) {
              return const Text('TESTE');
            })
    ),
    Container(
        color: const Color(0xFFB82000),
        child: DragTarget(
            builder: (context, cadidateData, rejectedData) {
              return const Text('TESTE');
            })
    ),
  ];
  final List<Widget> _opcaos = [
    Column(
      children: [
        Draggable(feedback: Container(
          child: const Text('public'),
        ), child: const Text('public')),
        Draggable(feedback: Container(
          child: const Text('private'),
        ), child: const Text('private')),
      ],
    ),
    Column(
      children: [
        Draggable(feedback: Container(
          child: const Text('public'),
        ), child: const Text('public')),
        Draggable(feedback: Container(
          child: const Text('private'),
        ), child: const Text('private')),
      ],
    ),
    Column(
      children: [
        Draggable(feedback: Container(
          child: const Text('public'),
        ), child: const Text('public')),
        Draggable(feedback: Container(
          child: const Text('private'),
        ), child: const Text('private')),
      ],
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              displayLevel(context),
              displayChance(context),
            ],
          ),
        ),
        body: GestureDetector(
          onDoubleTap: () {
            setState(() {
              selected = !selected;
            });
          },
          child: Column(
            children: [
              Expanded(
                  flex: selected ? 7 : 4,
                  child: displayChallengePrompt(context)),
              Expanded(
                  flex: selected ? 4 : 7, child: displayChallenge(context)),
              Divider(
                height: 20,
                thickness: 2,
                color: AppTheme.colorScheme.primaryContainer,
              ),
              Expanded(flex: 7, child: displayOptions(context))
            ],
          ),
        ));
  }

  Widget displayLevel(BuildContext context) {
    return const Text('Nivel');
  }

  Widget displayChance(BuildContext context) {
    return const Text('Tentativa');
  }

  Widget displayChallengePrompt(BuildContext context) {
    return Center(
      child: Container(
        color: selected ? const Color(0xFF006397) : const Color(0xFFB82000),
        alignment: Alignment.center,
        child: const Text('PROMPT'),
      ),
    );
  }

  Widget displayChallenge(BuildContext context) {
    return GridView.count(
        padding: const EdgeInsets.all(10),
        crossAxisCount: 8,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        children: _challengeSpaces,
    );
  }

  Widget displayOptions(BuildContext context) {
    return Row(
      children: _opcaos,
    );
  }
}
