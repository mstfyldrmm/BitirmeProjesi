import '../../export.dart';

class StudentAuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final studentCollection = FirebaseCollections.students.reference;
  final ServiceLocalStorage serviceLocalStorage =
      locator<ServiceLocalStorage>();
  final _logger = Logger(printer: PrettyPrinter());

  Future<StudentModel?> signInStudent(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        showToast(LocaleKeys.errorCode_login_toastMessage.locale,
            isError: true);
        return null;
      }

      final studentId = "${firebaseUser.email?.split('@').first}";

      final studentData = await studentCollection.doc(studentId).withConverter(
        fromFirestore: (snapshot, _) {
          return StudentModel().fromFirebase(snapshot);
        },
        toFirestore: (value, _) {
          return {};
        },
      ).get();

      if (!studentData.exists) {
        showToast(LocaleKeys.errorCode_login_toastMessage2.locale,
            isError: true);
        return null;
      }

      return studentData.data();
    } on FirebaseAuthException catch (error) {
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
      showToast(
        "${LocaleKeys.errorCode_login_defaultMessage.locale} : ${e.toString()}",
        isError: true,
      );
      return null;
    }
  }

  Future<bool> sendPasswordResetLink(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      showToast(
        LocaleKeys.passwordReset_successMessage.locale,
        isError: false,
      );
      return true;
    } catch (e) {
      showToast(
        "${LocaleKeys.errorCode_login_defaultMessage.locale} : ${e.toString()}",
        isError: true,
      );
      return false;
    }
  }

  Future<StudentModel?> signUpStudent(
    String mailAddress,
    String password,
    StudentModel studentModel,
  ) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: mailAddress,
        password: password,
      );

      if (userCredential.user != null) {
        await registerStudent(studentModel);
        return studentModel;
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

  Future<void> updateStudentInfo(
      String studentId, String newName, String newSurname) async {
    try {
      await studentCollection.doc(studentId).update({
        'studentName': newName,
        'studentSurname': newSurname,
      });

      showToast(LocaleKeys.account_studentEditProfileMessage.locale,
          isError: false);
    } on FirebaseAuthException catch (error) {
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
      showToast(
          "${LocaleKeys.errorCode_login_defaultMessage.locale}: ${e.toString()}",
          isError: true);
    }
  }

  Future<bool> logOutStudent() async {
    try {
      await _auth.signOut();
      showToast(
        LocaleKeys.errorCode_logOut_toastMessage.locale,
        isError: false,
      );
      await serviceLocalStorage.logout();
      _logger.i("Başarılı çıkış");
      return true;
    } catch (error) {
      _logger.i("Çıkış başarısız");
      return false;
    }
  }

  Future<void> registerStudent(StudentModel studentModel) async {
    final studentId = studentModel.mailAddress?.split('@').first;
    studentModel.schoolNumber = int.parse(studentId!);

    studentModel.studentId = studentId;
    await studentCollection.doc(studentId).set(
          studentModel.toJson(),
        );
  }
}
