import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/features/authentication/domain/bloc/authentication_bloc.dart';
import 'package:tcc_hpw_hello_programming_world/features/navigation/navigation_routes.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late AuthenticationBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.I<AuthenticationBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is Authenticated) {
            return _WelcomeLayout(
              child: Column(
                children: [
                  Text((state).credentials.user.email ?? ''),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      _bloc.add(const SignOut());
                    },
                    child: const Text("Log out"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                          context, NavigationRoutes.challengePageRoute.call());
                    },
                    child: const Text("Learn!"),
                  ),
                ],
              ),
            );
          } else {
            return _WelcomeLayout(
              child: Column(
                children: [
                  if (state is ErrorOccurred)
                    const Text(
                      'Error signing in.',
                      style: TextStyle(color: Colors.red),
                    ),
                  ElevatedButton(
                    onPressed: () async {
                      _bloc.add(const SignIn());
                    },
                    child: const Text("Log in"),
                  ),
                ],
              ),
            );
          }
        });
  }
}

class _WelcomeLayout extends StatelessWidget {
  const _WelcomeLayout({
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Welcome!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            child,
          ],
        ),
      ),
    );
  }
}
