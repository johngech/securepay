import 'package:securepay/common/common_router.dart';
import 'package:securepay/payments/payment_router.dart';
import 'package:securepay/security/security_router.dart';
import 'package:securepay/users/user_router.dart';
import 'package:securepay/app_router.dart';

final routerConfig = createRouter([
  PaymentRouter(),
  SecurityRouter(),
  UserRouter(),
  CommonRouter(),
]);
