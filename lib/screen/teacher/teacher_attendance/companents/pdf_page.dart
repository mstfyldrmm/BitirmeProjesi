import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:qr_attendance_project/custom/ext/ext_string_localizations.dart';
import 'package:qr_attendance_project/generated/locale_keys.g.dart';
import 'package:qr_attendance_project/model/attendance_model.dart';

Page pdfPageWidget(
  String attendanceDate,
  String lessonName,
  List<AttendanceModel?> data,
  pw.Font robotoFont, // << yeni parametre
) {
  return pw.Page(
    margin: pw.EdgeInsets.all(20),
    build: (pw.Context context) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            '$attendanceDate-$lessonName',
            style: pw.TextStyle(
              font: robotoFont,
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 16),
          pw.TableHelper.fromTextArray(
            context: context,
            headers: [
              LocaleKeys.teacherLessonDetail_schoolNumber.locale,
              LocaleKeys.teacherLessonDetail_studentName.locale,
              LocaleKeys.teacherLessonDetail_studentSurname.locale
            ],
            data: data
                .map((e) => [
                      e?.studentId ?? '',
                      e?.studentName ?? '',
                      e?.studentSurname ?? ''
                    ])
                .toList(),
            border: pw.TableBorder.all(),
            cellAlignment: pw.Alignment.centerLeft,
            headerStyle: pw.TextStyle(
              font: robotoFont,
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
            cellStyle: pw.TextStyle(
              font: robotoFont,
              fontSize: 12,
              color: PdfColors.black,
            ),
            headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
          ),
        ],
      );
    },
  );
}
