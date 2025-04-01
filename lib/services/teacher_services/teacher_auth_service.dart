import '../../export.dart';

class TeacherAuthService {
  final teacherCollection = FirebaseCollections.teachers.reference;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ServiceLocalStorage serviceLocalStorage =
      locator<ServiceLocalStorage>();
  final _logger = Logger(printer: PrettyPrinter());

  Future<String?> getUserIdByEmail(String email) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null && user.email == email) {
        return user.uid; // Kullanıcının UID'sini döndür
      }
    } catch (e) {
      print("Error getting user UID: $e");
    }
    return null;
  }

  Future<TeacherModel?> signUpTeacher(
    String mailAddress,
    String password,
    TeacherModel teacherModel,
  ) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: mailAddress,
        password: password,
      );

      if (userCredential.user != null) {
        String teacherId = userCredential.user!.uid;
        teacherModel = teacherModel.copyWith(teacherId: teacherId);
        await registerTeacher(teacherModel, teacherId);
        return teacherModel;
      }
    } on FirebaseAuthException catch (error) {
      String errorMessage;

      switch (error.code) {
        case "operation-not-allowed":
          errorMessage =
              LocaleKeys.errorCode_register_operationNotAllowed.locale;
          break;
        case "weak-password":
          errorMessage = LocaleKeys.errorCode_register_weakPassword.locale;
          break;
        case "invalid-email":
          errorMessage = LocaleKeys.errorCode_register_invalidEmail.locale;
          break;
        case "email-already-in-use":
          errorMessage = LocaleKeys.errorCode_register_emailAlreadyInUse.locale;
          break;
        case "invalid-credential":
          errorMessage = LocaleKeys.errorCode_register_invalidCredential.locale;
          break;
        default:
          errorMessage =
              "${LocaleKeys.errorCode_login_defaultMessage.locale}${error.message}";
      }
      showToast(errorMessage, isError: true);
      return null;
    } catch (e) {
      showToast(LocaleKeys.errorCode_login_defaultMessage.locale,
          isError: true);
      return null;
    }
    return null;
  }

  Future<TeacherModel?> signInTeacher(String email, String password) async {
    try {
      // Firebase Authentication ile giriş yap
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Kullanıcıyı al
      final User? firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        showToast(LocaleKeys.errorCode_login_toastMessage.locale,
            isError: true);
        return null;
      }

      final teacherId = userCredential.user!.uid;

      final teacherData = await teacherCollection.doc(teacherId).withConverter(
        fromFirestore: (snapshot, _) {
          return TeacherModel().fromFirebase(snapshot);
        },
        toFirestore: (value, _) {
          return {};
        },
      ).get();

      if (!teacherData.exists) {
        showToast(LocaleKeys.errorCode_login_toastMessage2.locale,
            isError: true);
        return null;
      }

      return teacherData.data();
    } on FirebaseAuthException catch (error) {
      // Firebase Auth hatalarını yönet
      String errorMessage;

      switch (error.code) {
        case "invalid-email":
          errorMessage = LocaleKeys.errorCode_login_invalidEmail.locale;
          break;
        case "wrong-password":
          errorMessage = LocaleKeys.errorCode_login_wrongPassword.locale;
          break;
        case "user-not-found":
          errorMessage = LocaleKeys.errorCode_login_userNotFound.locale;
          break;
        case "user-disabled":
          errorMessage = LocaleKeys.errorCode_login_userDisabled.locale;
          break;
        case "too-many-requests":
          errorMessage = LocaleKeys.errorCode_login_tooManyRequests.locale;
          break;
        case "operation-not-allowed":
          errorMessage = LocaleKeys.errorCode_login_operationNotAllowed.locale;
          break;
        default:
          errorMessage = LocaleKeys.errorCode_login_errrorMessage.locale;
      }

      showToast(errorMessage, isError: true);
      return null;
    } catch (e) {
      // Firestore veya diğer hataları yönet
      showToast(
        "${LocaleKeys.errorCode_login_defaultMessage.locale} : ${e.toString()}",
        isError: true,
      );
      return null;
    }
  }

  Future<void> updateTeacherInfo(
      String teacherId, String newName, String newSurname) async {
    try {
      await teacherCollection.doc(teacherId).update({
        'teacherName': newName,
        'teacherSurname': newSurname,
      });

      showToast(LocaleKeys.studentAccount_editProfileMessage.locale,
          isError: false);
    } on FirebaseAuthException catch (error) {
      // Firebase Auth hataları
      String errorMessage;
      switch (error.code) {
        case "weak-password":
          errorMessage = LocaleKeys.errorCode_register_weakPassword.locale;
          break;
        case "requires-recent-login":
          errorMessage = LocaleKeys.errorCode_login_defaultMessage.locale;
          break;
        default:
          errorMessage = LocaleKeys.errorCode_login_defaultMessage.locale;
      }
      showToast(errorMessage, isError: true);
    } catch (e) {
      // Diğer hatalar
      showToast(
          "${LocaleKeys.errorCode_login_defaultMessage.locale}: ${e.toString()}",
          isError: true);
    }
  }

  Future<bool> logOutTeacher() async {
    try {
      await _auth.signOut();
      showToast(
        LocaleKeys.errorCode_logOut_toastMessage.locale,
        isError: false,
      );
      await serviceLocalStorage.clearAll();
      _logger.i("Başarılı çıkış");
      return true;
    } catch (error) {
      _logger.i("Çıkış başarısız");
      return false;
    }
  }

  Future<void> registerTeacher(
      TeacherModel teacherModel, String teacherId) async {
    await teacherCollection.doc(teacherId).set(teacherModel.toJson());
  }
}
