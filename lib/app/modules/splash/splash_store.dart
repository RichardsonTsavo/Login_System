import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:mobx/mobx.dart';
import 'package:portfolio/app/shared/auth/auth_controller.dart';
import 'package:portfolio/app/shared/utils/style/style.dart';

part 'splash_store.g.dart';

class SplashStore = _SplashStoreBase with _$SplashStore;
abstract class _SplashStoreBase with Store {
  final AuthController _authController = Modular.get();

  Future<void> getPersistentLogin() async {
    _authController.loginWithLocalData();
  }

  Future setColor() async {
    final ConstStyle constStyle = ConstStyle();
    await FlutterStatusbarcolor.setStatusBarColor(constStyle.transparent, animate: true);
    if (useWhiteForeground(constStyle.transparent)) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
    } else {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    }
  }
}