import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/components/pill_container.dart';
import 'package:tcc_hpw_hello_programming_world/config/themes/app_theme.dart';
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
    _bloc.add(const AuthenticationEvent.signIn());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<AuthenticationBloc, AuthenticationState>(
            bloc: _bloc,
            listenWhen: (previous, current) =>
                previous is! Authenticated && current is Authenticated,
            listener: (context, state) =>
                Navigator.push(context, NavigationRoutes.mainPageRoute.call()),
          ),
          BlocListener<AuthenticationBloc, AuthenticationState>(
            bloc: _bloc,
            listenWhen: (previous, current) =>
                previous is Authenticated && current is! Authenticated,
            listener: (context, state) =>
                _bloc.add(const AuthenticationEvent.signIn()),
          ),
        ],
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            bloc: _bloc,
            builder: (context, state) {
              if (state is ErrorOccurred) {
                return Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network('https://i.imgur.com/ePW6QE3.png'),
                        Text(
                          "Você deve fazer login para continuar",
                          textAlign: TextAlign.center,
                          style: AppTheme.themeData.textTheme.titleSmall!
                              .copyWith(color: AppTheme.colorScheme.secondary),
                        ),
                        const SizedBox(height: 10),
                        PillContainer(
                          text: 'Login',
                          backgroundColor: AppTheme.colorScheme.primary,
                          textColor: Colors.white,
                          onTap: () =>
                              _bloc.add(const AuthenticationEvent.signIn()),
                        )
                      ],
                    ),
                  ),
                );
              }
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }));
  }
}
