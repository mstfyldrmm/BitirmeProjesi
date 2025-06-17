import 'package:qr_attendance_project/export.dart';

class TeacherLessonDetailView extends ChangeNotifier {
  ValueNotifier<Map<String, int>> attendanceCount =
      ValueNotifier<Map<String, int>>({});
  ValueNotifier<List<String>> dates = ValueNotifier<List<String>>([]);

  Future<Map<String, int>> fetchLessonAllAttendancesCount({
    required String lessonId,
  }) async {
    Map<String, int>  data =
        await AttendanceService().getAttendanceCountGroupedByDate(lessonId);
    dates.value = data.keys.toList();
    //tarih-yoklama katilan ogrenci sayisi verisi alindi.
    LessonModel? lessonData = await TeacherService().fetchLessonInfo(lessonId);
    int lessonStudentsCount = lessonData?.students?.length ?? 0;
    Map<String, int> tempCount = {};

    for (String date in data.keys) {
      int attendedCount = data[date] ?? 0;
      double percentage = (attendedCount /
              (lessonStudentsCount > 0 ? lessonStudentsCount : 1)) *
          100;

      tempCount[date] = percentage.round();
    }
    attendanceCount.value = tempCount;
    return attendanceCount.value;
  }
}
