import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:store_mg_fl/common/utils/shared_preference.dart';

final sharedPrefLocalProvider = Provider<SharedPreferenceLocal>((ref) {
  final pref = SharedPreferenceLocal();
  return pref;
});
