import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/features/give_help/data/rest_client/give_help_rest_client.dart';

class GiveHelpRepository {
  Future sendHelp(
    String data,
    String challengeId,
  ) {
    var client = GetIt.I<GiveHelpRestClient>();
    return client.sendHelp(data, challengeId);
  }
}
