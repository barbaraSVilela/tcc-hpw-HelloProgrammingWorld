/*
 * Copyright 2022 ArcTouch LLC.
 *
 * All rights reserved.
 *
 * This file, its contents, concepts, methods, behavior, and operation
 * (collectively the “Software”) are protected by trade secret, patent,
 * and copyright laws. The use of the Software is governed by a license
 * agreement. Disclosure of the Software to third parties, in any form,
 * in whole or in part, is expressly prohibited except as authorized by
 * the license agreement.
 */

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/domain/entity/challenge.dart';

part 'challenge_rest_client.g.dart';

@RestApi()
abstract class ChallengeRestClient {
  factory ChallengeRestClient(Dio dio) = _ChallengeRestClient;

  @GET('/challenge')
  Future<Challenge> getDailyChallenge();
}
