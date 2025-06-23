// Project imports:
import 'package:riddhi_clone/config/env/my_env.dart';

class AppEnv {
  static String get baseUrl => MyEnv.baseUrl;
  static String get sentryUrl => MyEnv.sentryUrl;
  static String get preferenceHelperEncryptionKey => MyEnv.preferenceHelperEncryptionKey;
  static String get presignedUrl => MyEnv.presignedUrl;
}
