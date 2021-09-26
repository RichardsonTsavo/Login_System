// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthController on _AuthController, Store {
  final _$userAtom = Atom(name: '_AuthController.user');

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$registerWithEmailAndPasswordAsyncAction =
      AsyncAction('_AuthController.registerWithEmailAndPassword');

  @override
  Future<dynamic> registerWithEmailAndPassword(
      {required String email, required String password}) {
    return _$registerWithEmailAndPasswordAsyncAction.run(() =>
        super.registerWithEmailAndPassword(email: email, password: password));
  }

  final _$recoverPasswordAsyncAction =
      AsyncAction('_AuthController.recoverPassword');

  @override
  Future<dynamic> recoverPassword({required String email}) {
    return _$recoverPasswordAsyncAction
        .run(() => super.recoverPassword(email: email));
  }

  final _$loginWithLocalDataAsyncAction =
      AsyncAction('_AuthController.loginWithLocalData');

  @override
  Future<dynamic> loginWithLocalData() {
    return _$loginWithLocalDataAsyncAction
        .run(() => super.loginWithLocalData());
  }

  final _$loginWithEmailAndPasswordAsyncAction =
      AsyncAction('_AuthController.loginWithEmailAndPassword');

  @override
  Future<dynamic> loginWithEmailAndPassword(
      {required String email, required String password}) {
    return _$loginWithEmailAndPasswordAsyncAction.run(() =>
        super.loginWithEmailAndPassword(email: email, password: password));
  }

  final _$loginWithGoogleAsyncAction =
      AsyncAction('_AuthController.loginWithGoogle');

  @override
  Future<dynamic> loginWithGoogle() {
    return _$loginWithGoogleAsyncAction.run(() => super.loginWithGoogle());
  }

  final _$loginWithFacebookAsyncAction =
      AsyncAction('_AuthController.loginWithFacebook');

  @override
  Future<dynamic> loginWithFacebook() {
    return _$loginWithFacebookAsyncAction.run(() => super.loginWithFacebook());
  }

  final _$_AuthControllerActionController =
      ActionController(name: '_AuthController');

  @override
  dynamic setUser(User value) {
    final _$actionInfo = _$_AuthControllerActionController.startAction(
        name: '_AuthController.setUser');
    try {
      return super.setUser(value);
    } finally {
      _$_AuthControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user}
    ''';
  }
}
