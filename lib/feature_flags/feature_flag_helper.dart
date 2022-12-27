import 'package:moneygram/feature_flags/feature.dart';
import 'package:moneygram/feature_flags/feature_flag_keys.dart';
import 'package:moneygram/feature_flags/fire_flag.dart';

class FeatureFlagHelper {
  static FeatureFlagHelper? _instance;

  static var features = Features(features: [
    Feature(
      name: FeatureFlagKeys.LATEST_APP_VERSION,
      value: "1.0.0",
    ),
    Feature(
      name: FeatureFlagKeys.MIN_APP_VERSION,
      value: "1.0.0",
    ),
  ]);

  final fireFlag = FireFlag(
    features: features,
    fetchExpirationDuration: const Duration(seconds: 0),
  );

  static FeatureFlagHelper get instance {
    if (_instance == null) {
      _instance = FeatureFlagHelper._internal();
    }

    return _instance!;
  }

  FeatureFlagHelper._internal();

  init() {
    setupFeatureFlags();
  }

  void setupFeatureFlags() {
    retrieveFeatureFlag();
  }

  void retrieveFeatureFlag() {
    fireFlag.featureFlagSubscription().listen((features) {
      features = features;
    });
  }

  bool isEnabled(String featureName) {
    return features.featureIsEnabled(featureName);
  }
}
