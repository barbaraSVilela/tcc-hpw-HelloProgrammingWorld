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

part 'give_help_rest_client.g.dart';

@RestApi()
abstract class GiveHelpRestClient {
  factory GiveHelpRestClient(Dio dio) = _GiveHelpRestClient;

  @POST('/help')
  Future sendHelp(
    @Query("data") String data,
    @Query("challengeId") String challengeId,
  );
}
