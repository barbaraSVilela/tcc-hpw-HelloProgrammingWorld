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
    return Scaffold(body: Center(
      child: BlocBuilder<ChallengeBloc,ChallengeState>(
        bloc: _bloc,
        builder: (context,state){
          if(state is Loading){
            return Column(
              children: [Text("Desafio Carregando"), CircularProgressIndicator()],
            );
          }
          else if(state is Loaded){
            Challenge _challenge = state.challenge;
            return Column(
              children: [
                Expanded(child: _displayChallengePrompt(context, _challenge.prompt),flex: 3),
                Expanded(child: _displayChallenge(context, _challenge.solution),flex: 6),
                Expanded(child: _displayButtonsAndInfo(context, _challenge.level, 1),flex: 1),
                Expanded(child: Text("Teste"),flex:5)
              ],
            );
          }else{
            return Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text("Error loading challenge",
                  style: TextStyle(
                    color: AppTheme.colorScheme.error
                  ),));
          }
    } ,
      )
    )
    );

  }

  Widget _displayChallengePrompt(BuildContext context, String challengePrompt) {
    return Scaffold(
      backgroundColor: AppTheme.colorScheme.inversePrimary,
      body:ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(top:50.0),
          children: [Center(child: Text("Desafio", style: TextStyle(fontWeight: FontWeight.bold))), Text(challengePrompt)])
    );

      Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2.0, color: Colors.black)
        ),
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child:  Column(
            children: [const Text("Desafio", style: TextStyle(fontWeight: FontWeight.bold)), Text(challengePrompt)],
          ),
        )
      ),
    );
  }

  Widget _displayChallenge(BuildContext context, List<String> solution) {
    return Scaffold(
        body: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 80.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0
            ),
            padding: const EdgeInsets.all(8.0),
            itemCount: solution.length,
            itemBuilder: (context, index) {
              return Container(
              child: _buildOptionWithDropZone(solution[index])
              );
            }
    ));
  }
  Widget _buildOptionWithDropZone(String option) {
    return Expanded(
        child: DragTarget(
            builder: (context, candidateOption,rejectedOption){
              return ColoredBox(color: AppTheme.colorScheme.secondary);
            }
          )
        );
  }
  Widget _displayButtonsAndInfo(BuildContext context,int level, int attempt){
    return Container(
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
              onPressed: null,
              child: Text(
                  "Run"
              )),
          Text("Nível: $level"),
          Text("Tentativa: $attempt"),
          ElevatedButton(
              onPressed: null,
              child: Text(
                  "Desistir"
              ))
        ],
      ),
    );
  }
  Widget _buildOptions(BuildContext context,List<String> options){
    return Scaffold(
      body: ListView.builder(
          itemBuilder: (context,index){
            return 
          })
    );
  }
}

