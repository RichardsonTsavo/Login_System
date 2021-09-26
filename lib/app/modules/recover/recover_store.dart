import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:portfolio/app/shared/auth/auth_controller.dart';

part 'recover_store.g.dart';

class RecoverStore = _RecoverStoreBase with _$RecoverStore;
abstract class _RecoverStoreBase with Store {
  String email = "";
  final AuthController _authController = Modular.get();
  @observable
  bool isLoading = false;

  @action
  Future recoverPassword() async {
    isLoading = true;
    await _authController.recoverPassword(
      email: email,
    );
    isLoading = false;
  }
}