import 'package:firebase_auth/firebase_auth.dart';
import 'package:portfolio/app/shared/service/firestore_repository_interface.dart';

class FirestoreRepository implements IFirestoreRepositoryInterface {

  @override
  Future recoverPassword({required String email}) async {
    return await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
