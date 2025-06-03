import 'package:pdf/widgets.dart' as pw;
import 'package:qr_attendance_project/export.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class TeacherAttendanceAnalysisView extends ChangeNotifier {
  ValueNotifier<Map<String, List<AttendanceModel>>?> attendanceList =
      ValueNotifier<Map<String, List<AttendanceModel>>?>(null);
  ValueNotifier<List<String>> dates = ValueNotifier<List<String>>([]);
  ValueNotifier<File?> pdfFile = ValueNotifier(null);
  final _logger = Logger(printer: PrettyPrinter());

  Future<Map<String, List<AttendanceModel>>> fetchLessonAllAttendances({
    required String lessonId,
  }) async {
    final data =
        await AttendanceService().getAttendancesGroupedByDate(lessonId);
    attendanceList.value = data;
    dates.value = data.keys.toList();
    return attendanceList.value ?? {};
  }

  Future<pw.Font> loadRobotoFont() async {
    final fontData = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
    return pw.Font.ttf(fontData);
  }

  Future<File?> createPdfFile(String lessonName) async {
    final pdf = pw.Document();
    final robotoFont = await loadRobotoFont();

    for (MapEntry<String, List<AttendanceModel>> item
        in attendanceList.value?.entries ?? []) {
      final date = item.key; // örn: "2025-04-12"
      final students = item.value; // List<AttendanceModel>
      _logger.i("Pdf eklenecek veri: ${date} ${students}");
      pdf.addPage(
        pdfPageWidget(date, lessonName, students, robotoFont),
      );
    }

    final outputDir = await getApplicationDocumentsDirectory();
    final file = File('${outputDir.path}/$lessonName.pdf');
    await file.writeAsBytes(await pdf.save());
    pdfFile.value = file;
    return pdfFile.value;
  }

  Future<void> sharePDF(String lessonName, File? sharingFile) async {

    if (sharingFile != null) {
      final params = ShareParams(
        text: "$lessonName.pdf",
        files: [XFile(sharingFile.path)],
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
