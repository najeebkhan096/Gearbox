
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gearbox/modal/user.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
class AuthService {



  // create user obj based on firebase user


  MyUser? _userFromFirebaseUser(User? user) {

    return user != null ? MyUser(uid: user.uid,email: user.email.toString()
    ) : null;
  }



  // auth change user stream
  Stream<MyUser?> get user {

    return auth.authStateChanges()
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }


  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      FirebaseAuthException abc=error as FirebaseAuthException;

      throw abc.message.toString();
    }
  }


  // register with email and password
  Future registerWithEmailAndPassword({required String ? email,required String ? password}) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(email: email!,
          password: password!);
      User? user = result.user;

      // return _userFromFirebaseUser(user);
      return user;
    } catch (error) {
      FirebaseAuthException abc=error as FirebaseAuthException;

      throw abc.message.toString();

    }
  }

  // sign out
  Future signOut() async {
    try {
      return await auth.signOut();
    } catch (error) {

      return null;
    }
  }

}

