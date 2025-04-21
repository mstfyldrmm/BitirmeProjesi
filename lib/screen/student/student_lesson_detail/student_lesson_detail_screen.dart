import 'package:qr_attendance_project/export.dart';
import 'package:qr_attendance_project/screen/student/student_lesson_detail/components/lesson_case_text.dart';

class StudentLessonDetailScreen extends StatelessWidget with IconCreater {
  const StudentLessonDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double dersDevam = 0.65;
    return Scaffold(
      appBar: CustomAppBar(context, title: 'E-Yoklama'),
      body: Padding(
        padding: WidgetSizes.normalPadding.value,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(flex: 3, child: StudentAttendanceStartButton(context)),
            Expanded(flex: 3, child: LessonAttendanceBar(dersDevam, context)),
            Expanded(
              child: LessonCaseText(),
            ),
            createLastAttendanceText(context),
            LastAttendanceWidget()
          ],
        ),
      ),
    );
  }

  

  Text createLastAttendanceText(BuildContext context) {
    return Text(
      'Geçmiş Yoklamalar',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class LastAttendanceWidget extends StatelessWidget {
  const LastAttendanceWidget({
    super.key,
  });

  //Veriler elle olusturuldu. Daha sonra page view builder ile düzeltilecek ve components eklenecek.
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Card.filled(
        shadowColor: Theme.of(context).primaryColor,
        child: PageView(
          children: [
            Card(
              child: ListTile(
                  title: Text(
                    '4 Mart 2025',
                  ),
                  subtitle: Text('Mikroişlemciler'),
                  trailing: Image.asset('assets/icons/cancel.png')),
            ),
            Card(
              child: ListTile(
                  title: Text(
                    '4 Mart 2025',
                  ),
                  trailing: Image.asset('assets/icons/accept.png')),
            ),
            Card(
              child: ListTile(
                  title: Text(
                    '4 Mart 2025',
                  ),
                  trailing: Image.asset('assets/icons/accept.png')),
            ),
            Card(
              child: ListTile(
                title: Text(
                  '4 Mart 2025',
                ),
                trailing: Image.asset('assets/icons/cancel.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
