import 'package:excel/excel.dart';
import 'package:qr_attendance_project/export.dart';

class TeacherAddLessonView extends ChangeNotifier {
  ValueNotifier<List<String>> students = ValueNotifier([]);
  ValueNotifier<File?> exelFile = ValueNotifier(null);
  ValueNotifier<String> lessonId = ValueNotifier('');
  ValueNotifier<String> lessonName = ValueNotifier('');
  ValueNotifier<String> lessonCode = ValueNotifier('');
  ValueNotifier<String> lessonSection = ValueNotifier('');
  ValueNotifier<String> lessonClass = ValueNotifier('1');
  ValueNotifier<bool> fileSelected = ValueNotifier(false);
  ValueNotifier<bool> studentsFetch = ValueNotifier(false);

  final _logger = Logger(printer: PrettyPrinter());

  void fileSelectedStateManage() {
    //dosya secilip secilmeme durumunu buradan yonettim
    fileSelected.value = !fileSelected.value;
  }

  /// excel returns filename
  String getExcelFileName() {
    return exelFile.value?.path.substring(79) ?? '';
  }

  /// deletes read data
  void deleteExcelData() {
    exelFile.value = null;
    lessonCode.value = '';
    lessonName.value = '';
    lessonSection.value = '';
    fileSelectedStateManage();
  }

  Future<bool> completeLessonRegistration(String teacherId) async {
    String teacherName = await fetchTeacherName(teacherId);
    bool firstStep = await saveLessonFirebase(
        teacherName: teacherName); //ilk olarak dersi firebase kayit yapiyorum
    bool? secondStep;
    bool? lastStep;
    if (firstStep) {
      //Gereksiz yere öğretmen kayit calismamasi için if var!!
      secondStep = await saveTeacherLessons(teacherId, lessonId.value);
      lastStep = await addLessonStudents();
    }
    final isSuccess = firstStep && secondStep! && lastStep!;
    return isSuccess;
  }

  /// Add courses to existing students
  Future<bool> addLessonStudents() async {
    final isSuccess = await StudentService().updateStudentsWithLesson(
      studentsIds: students.value,
      lessonId: lessonId.value,
    );
    return isSuccess;
  }

  Future<bool> saveLessonFirebase({required String teacherName}) async {
    bool studentExelReadState = await readExcel();

    if (studentExelReadState) {
      var idState = await TeacherService().addLessonFirebase(
        LessonModel(
          classLevel: lessonClass.value,
          lessonCode: lessonCode.value,
          lessonName: lessonName.value,
          section: lessonSection.value,
          students: students.value,
          teacherName: teacherName,
        ),
      );
      if (idState != null) {
        lessonId.value = idState;
        _logger.i("Ders eklendi : ${lessonId.value}");
        return true;
      }
      _logger.i("Ders eklenemedi");
      return false;
    } else {
      _logger.i("Öğrenci listesi okunamadı");
      return false;
    }
  }

  Future<bool> saveTeacherLessons(
    String teacherId,
    String lessonId,
  ) async {
    bool state = await TeacherService().addLessonTeacher(teacherId, lessonId);
    state
        ? _logger.i("Ders öğretmene kaydedildi")
        : _logger.i("Ders öğretmene kaydedilemedi");
    return state;
  }

  Future<String> fetchTeacherName(String teacherId) async {
    TeacherModel? teacherModel;
    teacherModel = await TeacherService().fetchTeacher(teacherId);
    return "${teacherModel?.teacherName} ${teacherModel?.teacherSurname}"
        .toUpperCase();
  }

  Future<bool> pickExcelFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );

      if (result != null) {
        exelFile.value = File(result.files.single.path!);
        _logger.i('Dosya seçimi basarili');
        fileSelectedStateManage();
        return true;
      }
    } catch (e) {
      _logger.i('Dosya seçiminde hata olustu');
      return false;
    }
    return false;
  }

  Future<bool> readExcel() async {
    final file = exelFile.value;
    final studentIdColumnName = "öğrenci no";
    final lessonCodeName = "ders kodu";

    if (file != null) {
      var bytes = await file.readAsBytes();
      var excel = Excel.decodeBytes(bytes);

      List<String> studentIds = [];

      try {
        for (var table in excel.tables.keys) {
          //exel dosyasındaki her tabloyu döngüye alıyor.
          var rows = excel.tables[table]!.rows;
          int studentIdColumnIndex = -1;
          int lessonCodeColumnIndex = -1;
          for (var item in rows) {
            //her satırdaki her elemanı döngüye alıyor.
            if ((item.toString().toLowerCase())
                .contains(lessonCodeName.toLowerCase())) {
              String content = item.toString().substring(
                  item.toString().indexOf('(') + 1,
                  item.toString().lastIndexOf(')'));

              String dataContent = content.split('Data(')[1].split('),')[0];
              String firstField = dataContent.split(',')[0].trim();
              List<String> parts = firstField.split('-');

              lessonCode.value = parts[0];
              lessonName.value = parts[1];
              continue;
            }
            for (var index in item) {
              for (int i = 0; i < item.length; i++) {
                if ((index?.value?.toString().toLowerCase() ?? '')
                    .contains(studentIdColumnName.toLowerCase())) {
                  studentIdColumnIndex = i;
                  lessonCodeColumnIndex = i + 5;
                  break;
                }
              }
            }
          }

          if (studentIdColumnIndex != -1) {
            for (var row in rows.sublist(1)) {
              if (row.length > studentIdColumnIndex &&
                  row.length > lessonCodeColumnIndex) {
                var cell = row[studentIdColumnIndex + 1];
                var studentId = cell?.value?.toString().trim();
                var lessonSectionColumn =
                    row[lessonCodeColumnIndex]?.value.toString().trim();

                if (lessonSectionColumn != null &&
                    lessonSectionColumn.isNotEmpty) {
                  lessonSection.value =
                      lessonSectionColumn.split('/').last.trim();
                }

                if (studentId != null && studentId.isNotEmpty) {
                  studentIds.add(studentId);
                }
              }
            }
          }
          students.value = studentIds.sublist(2);
          _logger.i(
            "Derse ait bilgiler : ogrenci listesi: ${studentIds} "
            "ders kodu:${lessonCode.value} ders adi:${lessonName.value} "
            "ders bolumu: ${lessonSection.value}",
          );
          return true;
        }
      } catch (e) {
        _logger.e("read error: $e");
        showToast(
          LocaleKeys.errorCode_teacherAddLesson_readExcel.locale,
          isError: true,
        );
        return false;
      }
    }
    return false;
  }

  String? validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validate_noEmpty.locale;
    }
    return null;
  }
}
