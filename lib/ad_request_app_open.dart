/// Targeting info per the AdMob API.
///
/// This class's properties mirror the native AdRequest API. See for example:
/// [AdRequest.Builder for Android](https://developers.google.com/android/reference/com/google/android/gms/ads/AdRequest.Builder).
class AdRequestAppOpen {
  /// Default constructor for [AdRequest].
  const AdRequestAppOpen({
    this.keywords,
    this.contentUrl,
    this.testDevices,
    this.nonPersonalizedAds,
  });

  /// Words or phrases describing the current user activity.
  final List<String>? keywords;

  /// URL string for a webpage whose content matches the app’s primary content.
  ///
  /// This webpage content is used for targeting and brand safety purposes.
  final String? contentUrl;

  /// Causes a device to receive test ads.
  ///
  /// The deviceId can be obtained by viewing the logcat output after creating a
  /// new ad. This method should only be used while debugging. Be sure to remove
  /// all calls to this method before releasing your app.
  final List<String>? testDevices;

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
    if (testDevices != null && testDevices!.isNotEmpty) {
      assert(testDevices!.every((String s) => s.isNotEmpty));
      json['testDevices'] = testDevices;
    }

    return json;
  }

  factory AdRequestAppOpen.fromJson(Map<String, dynamic> json){
    return AdRequestAppOpen(
      keywords: json['keywords'] ?? [],
      testDevices: json['testDevices'] ?? [],
      nonPersonalizedAds: json['nonPersonalizedAds'],
      contentUrl: json['contentUrl'],
    );
  }
}