// Project imports:
import 'package:riddhi_clone/config/flavours/app.dart';

void main() async {
  await AppConfig.instance.setAppConfig(environment: Environment.prod);
}
