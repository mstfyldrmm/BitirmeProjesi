import 'package:qr_attendance_project/export.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class TeacherAttendanceView extends ChangeNotifier {
  ValueNotifier<List<AttendanceModel?>> attendancesData = ValueNotifier([]);
  ValueNotifier<List<AttendanceModel?>> filteredAttendancesData =
      ValueNotifier([]);
  ValueNotifier<bool> isLoading = ValueNotifier(true);
  ValueNotifier<String> selectedDate =
      ValueNotifier(DateTime.now().toString().split(" ")[0]);
  ValueNotifier<File?> pdfFile = ValueNotifier(null);

  Future<List<AttendanceModel?>> getRegisteredStudents(String lessonId) async {
    final data = await AttendanceService().getStudentAttendances(
      lessonId: lessonId,
      date: selectedDate.value,
    );
    attendancesData.value = data;
    filteredAttendancesData.value = attendancesData.value;
    return attendancesData.value;
  }

  Future<String> selectDate(BuildContext context) async {
    DateTime? selectDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      selectedDate.value = selectDate.toString().split(" ")[0];
      return selectedDate.value;
    }
    return selectedDate.value;
  }

  void filterAttendances(String query) {
    if (query.isEmpty) {
      filteredAttendancesData.value = attendancesData.value;
    } else {
      final lowerQuery = query.toLowerCase();
      filteredAttendancesData.value = attendancesData.value;
      filteredAttendancesData.value = attendancesData.value.where((attendance) {
        final name =
            "${attendance?.studentName?.toLowerCase()} ${attendance?.studentSurname?.toLowerCase()}";
        final studenNumber = attendance?.studentId ?? '';
        return name.contains(lowerQuery) || studenNumber.contains(lowerQuery);
      }).toList();
    }
  }

  Future<pw.Font> loadRobotoFont() async {
    final fontData = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
    return pw.Font.ttf(fontData);
  }

  Future<void> createPdfFile(
    List<AttendanceModel?> data,
    String date,
    String lessonName,
  ) async {
    final pdf = pw.Document();
    final robotoFont = await loadRobotoFont();
    pdf.addPage(
      pdfPageWidget(date, lessonName, data, robotoFont),
    );
    final outputDir = await getApplicationDocumentsDirectory();
    final file = File('${outputDir.path}/${date}_$lessonName.pdf');
    await file.writeAsBytes(await pdf.save());
    pdfFile.value = file;
  }

  Future<void> sharePDF(
    String lessonName,
    String date,
    List<AttendanceModel?> data,
  ) async {
    await createPdfFile(data, date, lessonName);
    if (pdfFile.value != null) {
      final params = ShareParams(
        text: "$lessonName $date.pdf",
        files: [XFile(pdfFile.value!.path)],
      );
      final result = await SharePlus.instance.share(params);
      if (result.status == ShareResultStatus.success) {
        Logger().i('PDF shared successfully');
      }
    } else {
      print('PDF file is null');
    }
  }
}
