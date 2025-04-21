import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:qr_attendance_project/export.dart';

class TeacherAddLessonView with ChangeNotifier {
  ValueNotifier<List<String>> students = ValueNotifier([]);
  ValueNotifier<File?> exelFile = ValueNotifier(null);
  ValueNotifier<String?> lessonId = ValueNotifier('');
  ValueNotifier<String> lessonName = ValueNotifier('');
  ValueNotifier<String> lessonCode = ValueNotifier('');
  ValueNotifier<String> lessonSection = ValueNotifier('');
  ValueNotifier<bool> fileSelected = ValueNotifier(false);
  ValueNotifier<bool> studentsFetch = ValueNotifier(false);

  final _logger = Logger(printer: PrettyPrinter());

  void fileSelectedStateManage() {
    //dosya secilip secilmeme durumunu buradan yonettim
    fileSelected.value = !fileSelected.value;
  }

  Future<bool> saveLessonFirebase({required String teacherName}) async {
    bool studentExelReadState =
        await readExcel(exelFile.value, "öğrenci numara");

    if (studentExelReadState) {
      var idState = await TeacherService().addLessonFirebase(LessonModel(
          lessonCode: lessonCode.value,
          lessonName: lessonName.value,
          section: lessonSection.value,
          students: students.value,
          teacherName: teacherName));
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

  Future<bool> saveStudentsLessons(
      List<String> students, String lessonId) async {
    List<Future<bool>> futures = [];

    for (var student in students) {
      futures.add(StudentService().addLessonStudent(student, lessonId));
    }

    List<bool> results = await Future.wait(futures);
    bool allSuccessful = results.every((result) => result);

    allSuccessful
        ? _logger.i("Tüm öğrencilere ders eklendi")
        : _logger.e("Bazı öğrencilere ders eklenemedi");

    return allSuccessful;
  }

  //Bool donmeli mi donmememli mi kontrol et
  Future<bool> saveTeacherLessons(String teacherId, String lessonId) async {
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

  Future<bool> readExcel(File? file, String studentIdColumnName) async {
    // Excel dosyasını okur ve tüm satırlarda verilen kolon adını bulur daha sonra gerekli veriyi döner.
    if (file != null) {
      var bytes = await file.readAsBytes();
      var excel = Excel.decodeBytes(bytes);

      List<String> studentIds = [];

      for (var table in excel.tables.keys) {
        var rows = excel.tables[table]!.rows;
        int studentIdColumnIndex = -1;
        for (var item in rows) {
          for (var index in item) {
            for (int i = 0; i < item.length; i++) {
              if ((index?.value?.toString().toLowerCase() ?? '')
                  .contains(studentIdColumnName.toLowerCase())) {
                studentIdColumnIndex = i;
                break;
              }
            }
          }
        }

        if (studentIdColumnIndex != -1) {
          for (var row in rows.sublist(1)) {
            var studentId = row.isNotEmpty
                ? row[studentIdColumnIndex]?.value.toString()
                : '';

            if (studentId!.isNotEmpty) {
              studentIds.add(studentId);
            }
          }
        }
      }
      students.value = studentIds.sublist(1);
      showToast("Öğrenci listesi okundu", isError: false);
      return true;
    } else {
      showToast("Öğrenci listesi okunamadi", isError: true);
      return false;
    }
  }

  String? validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validate_noEmpty.locale;
    }
    return null;
  }
}
