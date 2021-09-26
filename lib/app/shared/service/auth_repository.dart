import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:portfolio/app/shared/service/auth_repository_interface.dart';
import 'package:portfolio/app/shared/service/firestore_repository.dart';
import 'package:portfolio/app/shared/service/firestore_repository_interface.dart';

class AuthRepository implements IAuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final IFirestoreRepositoryInterface _firestoreRepository = FirestoreRepository();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Future getLogout() async {
    return _firebaseAuth.signOut();
  }

  @override
  Future recoverPassword({required String email}) async {
    return await _firestoreRepository.recoverPassword(email: email);
  }

  @override
  Future getEmailEndPasswordLogin(
      {required String email, required String password}) async {
    UserCredential value = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return value.user;
  }


  @override
  Future<User> setEmailEndPasswordLogin(
      {required String email,
        required String password}) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;
    return user!;
  }

  @override
  Future<User?> getUser() async {
    return _firebaseAuth.currentUser;
  }

  @override
  Future getFacebookLogin() async {
   final result = await FacebookLogin().logIn(permissions: [FacebookPermission.email,FacebookPermission.publicProfile]);
   switch(result.status){
     case FacebookLoginStatus.success:
       final AuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
       User? user = (await _firebaseAuth.signInWithCredential(credential)).user;
       return user;
     case FacebookLoginStatus.cancel:
       return null;
     case FacebookLoginStatus.error:
       return null;
   }
  }

  @override
  Future getGoogleLogin() async {
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth = await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth!.accessToken,
      idToken: googleAuth.idToken
    );
    User? user = (await _firebaseAuth.signInWithCredential(credential)).user;
    return user;
  }
}
