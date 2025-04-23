import 'package:qr_attendance_project/export.dart';

class TeacherFabWidget extends StatelessWidget
    with IconCreater, NavigatorManager {
  TeacherFabWidget({super.key, required this.teacherId});
  final String teacherId;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: iconCreaterColor('assets/icons/add-database.png', context),
        onPressed: () {
          navigateToWidget(context, TeacherAddLessonScreen(teacherId: teacherId,));
        });
  }
}
