// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bloc_presentation_test/bloc_presentation_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/components/pill_container.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/domain/entity/challenge.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/presentation/bloc/challenge_bloc.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/presentation/pages/challenge_page.dart';

class MockChallengeBloc extends MockBloc<ChallengeEvent, ChallengeState>
    implements ChallengeBloc {}

void main() {
  testWidgets('Loaded challenge is displayed as expected',
      (WidgetTester tester) async {
    final bloc = MockChallengeBloc();
    var state = const ChallengeState.loaded(
        challenge: Challenge(
          id: '',
          prompt: 'Challenge prompt',
          level: 0,
          coins: 0,
          solution: [],
        ),
        availableOptions: ['option 1', 'option 2'],
        attemptsLeft: 0);
    whenListen(
      bloc,
      Stream.fromIterable([state]),
      initialState: state,
    );
    whenListenPresentation(bloc);

    GetIt.I.registerLazySingleton<ChallengeBloc>(() => bloc);

    await tester
        .pumpWidget(const MaterialApp(home: Scaffold(body: ChallengePage())));

    expect(find.text('Challenge prompt'), findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (widget) => widget is PillContainer && widget.text == 'option 1'),
        findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (widget) => widget is PillContainer && widget.text == 'option 2'),
        findsOneWidget);
  });
}
