// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/domain/entity/challenge.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/presentation/bloc/challenge_bloc.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/presentation/pages/challenge_page.dart';

class MockChallengeBloc extends MockBloc<ChallengeEvent, ChallengeState>
    implements ChallengeBloc {}

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    final bloc = MockChallengeBloc();
    var state = const ChallengeState.loaded(
        challenge: Challenge(
          id: '',
          prompt: '',
          level: 0,
          coins: 0,
          solution: [],
          options: [],
        ),
        attemptsLeft: 0);
    whenListen(
      bloc,
      Stream.fromIterable([state]),
      initialState: state,
    );

    GetIt.I.registerLazySingleton<ChallengeBloc>(() => bloc);

    await tester.pumpWidget(const ChallengePage());

    expect(find.text('1'), findsNothing);
  });
}
