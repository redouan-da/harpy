import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:harpy/api/twitter/data/tweet.dart';
import 'package:harpy/api/twitter/services/twitter_service.dart';
import 'package:harpy/core/json/json_mapper.dart';

class TweetService extends TwitterService with JsonMapper<Tweet> {
  Future<List<Tweet>> getHomeTimeline() async {
    final response = await client
        .get("https://api.twitter.com/1.1/statuses/home_timeline.json");

//    var response = await rootBundle.loadString("example_tweet.json");

    if (response.statusCode == 200) {
      List<Tweet> tweets = map((map) {
        return Tweet.fromJson(map);
      }, response.body);
      return Future<List<Tweet>>(() => tweets);
    } else {
      return Future.error(response.body);
    }
  }
}
