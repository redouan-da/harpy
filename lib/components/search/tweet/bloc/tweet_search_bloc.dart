import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_twitter_api/api/tweets/tweet_search_service.dart';
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:harpy/components/search/tweet/filter/model/tweet_search_filter.dart';
import 'package:harpy/core/api/network_error_handler.dart';
import 'package:harpy/core/api/twitter/tweet_data.dart';
import 'package:harpy/core/service_locator.dart';
import 'package:logging/logging.dart';

part 'tweet_search_event.dart';
part 'tweet_search_state.dart';

class TweetSearchBloc extends Bloc<TweetSearchEvent, TweetSearchState> {
  TweetSearchBloc({
    String initialSearchQuery,
  }) : super(const TweetSearchInitial()) {
    if (initialSearchQuery != null && initialSearchQuery.trim().isNotEmpty) {
      add(SearchTweets(customQuery: initialSearchQuery));
    }
  }

  final TweetSearchService searchService = app<TwitterApi>().tweetSearchService;

  @override
  Stream<TweetSearchState> mapEventToState(
    TweetSearchEvent event,
  ) async* {
    yield* event.applyAsync(currentState: state, bloc: this);
  }
}
