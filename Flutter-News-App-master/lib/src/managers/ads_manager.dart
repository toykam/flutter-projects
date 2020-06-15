import 'package:firebase_admob/firebase_admob.dart';

const String testDevice = '8BCA638F58298B5A4A6E7AB915815232';

class AdsManager {
//  String get myAppId => BannerAd.testAdUnitId;
  String get myAppId => 'ca-app-pub-5257710322878608~5605162542';
  static const MobileAdTargetingInfo _mobileAdTargetingInfo =
      MobileAdTargetingInfo(
    keywords: ['News', 'Information', 'Sport News', 'Coronavirus'],
//    testDevices: [testDevice],
    nonPersonalizedAds: true,
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
//        adUnitId: InterstitialAd.testAdUnitId,
        adUnitId: 'ca-app-pub-5257710322878608/3850239501',
        targetingInfo: _mobileAdTargetingInfo,
        listener: (MobileAdEvent event) {
          print('Interstitial Ad Event:=> ' + event.toString());
        });
  }

  BannerAd createBannerAd() {
    return BannerAd(
//        adUnitId: BannerAd.testAdUnitId,
        adUnitId: 'ca-app-pub-5257710322878608/6981629877',
        size: AdSize.smartBanner,
        targetingInfo: _mobileAdTargetingInfo,
        listener: (MobileAdEvent event) {
          print('Ads Event: ' + event.toString());
          if (event == MobileAdEvent.failedToLoad) {}
        });
  }

  void showBannerAds() {
    _bannerAd = createBannerAd()
      ..load()
      ..show();
  }

  void showInterstitialAd() {
    _interstitialAd = createInterstitialAd()
      ..load()
      ..show();
  }

  AdsManager() {
    FirebaseAdMob.instance.initialize(appId: myAppId);
  }
}
