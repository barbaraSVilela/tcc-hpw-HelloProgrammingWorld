import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/components/pill_container.dart';
import 'package:tcc_hpw_hello_programming_world/config/themes/app_theme.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/domain/entity/challenge.dart';
import 'package:tcc_hpw_hello_programming_world/features/give_help/presentation/bloc/give_help_bloc.dart';

class GiveHelpPage extends StatefulWidget {
  const GiveHelpPage({
    super.key,
    required this.challenge,
  });

  final Challenge challenge;

  @override
  State<GiveHelpPage> createState() => _GiveHelpPageState();
}

class _GiveHelpPageState extends State<GiveHelpPage> {
  late GiveHelpBloc _bloc;
  late TextEditingController _controller;
  @override
  void initState() {
    _bloc = GetIt.I<GiveHelpBloc>();
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<GiveHelpBloc, GiveHelpEvent>(
      bloc: _bloc,
      listener: (context, event) {
        if (event is Submitted) {
          _showDialog();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.colorScheme.surface,
          foregroundColor: AppTheme.colorScheme.onSurface,
          centerTitle: true,
          title: const Text("Ajude outros"),
          leading: BackButton(onPressed: () => Navigator.pop(context)),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: PillContainer(
              text: 'Enviar',
              backgroundColor: AppTheme.colorScheme.primary,
              textColor: Colors.white,
              onTap: () => _bloc.add(Submit(
                  challengeId: widget.challenge.id, tip: _controller.text)),
            ),
          ),
        ),
        body: Padding(
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
                      const SizedBox(height: 30),
                      Container(
                        decoration: BoxDecoration(
                          color: AppTheme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            widget.challenge.prompt,
                            textAlign: TextAlign.center,
                            style: AppTheme.themeData.textTheme.titleLarge!
                                .copyWith(
                              color: AppTheme.colorScheme.primaryContainer,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _controller,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                            labelText:
                                "Dê dicas de estudo sobre o desafio acima"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Obrigado!'),
          content: const SingleChildScrollView(
            child: Text('Suas dicas foram submetidas com sucesso!'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
