/// Targeting info per the AdMob API.
///
/// This class's properties mirror the native AdRequest API. See for example:
/// [AdRequest.Builder for Android](https://developers.google.com/android/reference/com/google/android/gms/ads/AdRequest.Builder).
class AdRequestAppOpen {
  /// Default constructor for [AdRequest].
  const AdRequestAppOpen({
    this.keywords,
    this.contentUrl,
    this.nonPersonalizedAds,
  });

  /// Words or phrases describing the current user activity.
  final List<String>? keywords;

  /// URL string for a webpage whose content matches the app’s primary content.
  ///
  /// This webpage content is used for targeting and brand safety purposes.
  final String? contentUrl;

  /// Non-personalized ads are ads that are not based on a user’s past behavior.
  ///
  /// For more information:
  /// https://support.google.com/admob/answer/7676680?hl=en
  final bool? nonPersonalizedAds;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{
      'requestAgent': 'flutter-alpha',
    };

    if (keywords != null && keywords!.isNotEmpty) {
      assert(keywords!.every((String s) => s.isNotEmpty));
      json['keywords'] = keywords;
    }
    if (nonPersonalizedAds != null)
      json['nonPersonalizedAds'] = nonPersonalizedAds;
    if (contentUrl != null && contentUrl!.isNotEmpty)
      json['contentUrl'] = contentUrl;

    return json;
  }

  factory AdRequestAppOpen.fromJson(Map<String, dynamic> json) {
    return AdRequestAppOpen(
      keywords: json['keywords'] ?? [],
      nonPersonalizedAds: json['nonPersonalizedAds'],
      contentUrl: json['contentUrl'],
    );
  }
}
