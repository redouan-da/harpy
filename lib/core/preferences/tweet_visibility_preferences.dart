import 'package:harpy/core/api/twitter/tweet_data.dart';
import 'package:harpy/core/preferences/harpy_preferences.dart';
import 'package:harpy/core/service_locator.dart';

class TweetVisibilityPreferences {
  final HarpyPreferences harpyPrefs = app<HarpyPreferences>();

  int get lastVisibleTweet =>
      harpyPrefs.getInt('lastVisibleTweet', 0, prefix: true);
  set lastVisibleTweet(int value) =>
      harpyPrefs.setInt('lastVisibleTweet', value, prefix: true);

  void updateVisibleTweet(TweetData tweet) {
    final int id = int.tryParse(tweet.originalIdStr);

    if (id != null && id > lastVisibleTweet) {
      lastVisibleTweet = id;
    }
  }
}
