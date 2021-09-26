import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:portfolio/app/shared/service/auth_repository_interface.dart';
import 'package:portfolio/app/shared/service/shared_preferences_repository.dart';
import 'package:portfolio/app/shared/service/shared_preferences_repository_interface.dart';
import 'package:portfolio/app/shared/utils/snackbar/global_snack_bar.dart';

part 'auth_controller.g.dart';

class AuthController = _AuthController with _$AuthController;

abstract class _AuthController with Store {
  final IAuthRepository _authRepository = Modular.get();
  final ISharedPreferencesRepositoryInterface _sharedPreferencesRepository = SharedPreferencesRepository();
  GlobalSnackBar snackBar = const GlobalSnackBar();
  bool isAdmin = false;
  @observable
  User? user;

  @action
  setUser(User value) => user = value;

  _AuthController() {
    _authRepository.getUser().then((user) {
      if(user == null){
          return;
      }
      setUser(user);
    });

  }


  @action
  Future registerWithEmailAndPassword(
      {required String email,
        required String password}) async {
    user = await _authRepository.setEmailEndPasswordLogin(
        email: email, password: password);
    _sharedPreferencesRepository.save(key: "Credentials", item: <String>[
      email,
      password,
      "EmailAndPassword"
    ]);
    Modular.to.pushReplacementNamed("/home/");
    //isAdmin = await authRepository.getIsAdmin(id: userDocument.id);
  }

  @action
  Future recoverPassword({required String email}) async {
    try {
      await _authRepository.recoverPassword(email: email);
      snackBar.showSucessSnackbar("Request sent successfully! Go to the email you entered and follow the step by step");
      Modular.to.pop();
    } catch (onError) {
      snackBar.showErrorSnackbar(
          "Error when submitting request, please try again.");
    }
  }

  @action
  Future loginWithLocalData() async {
    try {
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      List<String>? dataCredentials =
          await _sharedPreferencesRepository.getInfo(key: "Credentials");
      if (dataCredentials != null) {
        switch(dataCredentials[2]){
          case "EmailAndPassword":
            user = await _authRepository.getEmailEndPasswordLogin(
              email: stringToBase64.decode(dataCredentials[0]) ,
              password: stringToBase64.decode(dataCredentials[1]),
            );
            break;
          case "google":
            user = await _authRepository.getGoogleLogin();
            break;
          case "facebook":
            user = await _authRepository.getFacebookLogin();
            break;
        }
        if(user != null){
          Modular.to.pushReplacementNamed("/home/");
        }else{
          Modular.to.pushReplacementNamed("/login/");
        }
      } else {
        Modular.to.pushReplacementNamed("/login/");
      }
    } catch (onError) {
      Modular.to.pushReplacementNamed("/login/");
    }
  }

  @action
  Future loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      user = await _authRepository.getEmailEndPasswordLogin(
          email: email, password: password);
      _sharedPreferencesRepository.save(key: "Credentials", item: <String>[
        stringToBase64.encode(email),
        stringToBase64.encode(password),
        "EmailAndPassword"
      ]);
      Modular.to.pushReplacementNamed("/home/");
    }on FirebaseAuthException catch (onError) {
      String errorMessage = "erro";
      switch (onError.code) {
        case "invalid-email":
          errorMessage = "Your email address seems to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "The user with this email does not exist.";
          break;
        case "user-disabled":
          errorMessage = "The user with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Many login requests at the moment. Wait a minute and try again.";
          break;
        default:
          errorMessage = "An undefined error happened.";
      }
      snackBar.showErrorSnackbar(errorMessage);
    }catch(onError){
      snackBar.showErrorSnackbar("An undefined error happened.");
    }
  }

  @action
  Future loginWithGoogle() async {
    try {
      user = await _authRepository.getGoogleLogin();
      _sharedPreferencesRepository.save(key: "Credentials", item: <String>[
        "",
        "",
        "google"
      ]);
      Modular.to.pushReplacementNamed("/home/");
    }on FirebaseAuthException catch (onError) {
      String errorMessage = "erro";
      switch (onError.code) {
        case "invalid-email":
          errorMessage = "Your email address seems to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "The user with this email does not exist.";
          break;
        case "user-disabled":
          errorMessage = "The user with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Many login requests at the moment. Wait a minute and try again.";
          break;
        default:
          errorMessage = "An undefined error happened.";
      }
      snackBar.showErrorSnackbar(errorMessage);
    }catch(onError){
      snackBar.showErrorSnackbar("An undefined error happened.");
    }
  }

  @action
  Future loginWithFacebook() async {
    try {
      user = await _authRepository.getFacebookLogin();
      if(user != null){
        _sharedPreferencesRepository.save(key: "Credentials", item: <String>[
          "",
          "",
          "facebook"
        ]);
        Modular.to.pushReplacementNamed("/home/");
      }
    }on FirebaseAuthException catch (onError) {
      String errorMessage = "erro";
      switch (onError.code) {
        case "invalid-email":
          errorMessage = "Your email address seems to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "The user with this email does not exist.";
          break;
        case "user-disabled":
          errorMessage = "The user with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Many login requests at the moment. Wait a minute and try again.";
          break;
        default:
          errorMessage = "An undefined error happened.";
      }
      snackBar.showErrorSnackbar(errorMessage);
    }catch(onError){
      print(onError);
      snackBar.showErrorSnackbar("An undefined error happened.");
    }
  }

  Future logOut() async {
    _sharedPreferencesRepository.deleteInfo();
    Modular.to.pushReplacementNamed("/login/");
    return _authRepository.getLogout();
  }
}
