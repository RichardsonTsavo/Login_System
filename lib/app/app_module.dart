import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio/app/modules/login/login_module.dart';
import 'package:portfolio/app/modules/recover/recover_module.dart';
import 'package:portfolio/app/modules/register/register_module.dart';
import 'package:portfolio/app/modules/splash/splash_module.dart';
import 'package:portfolio/app/shared/auth/auth_controller.dart';
import 'package:portfolio/app/shared/service/auth_repository.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AuthRepository()),
    Bind.lazySingleton((i) => AuthController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: SplashModule()),
    ModuleRoute("/login", module: LoginModule()),
    ModuleRoute("/home", module: HomeModule()),
    ModuleRoute("/recover", module: RecoverModule()),
    ModuleRoute("/signUp", module: RegisterModule()),
  ];

}