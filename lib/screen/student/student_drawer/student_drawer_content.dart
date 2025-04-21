import 'package:qr_attendance_project/export.dart';
import 'package:qr_attendance_project/screen/student/student_drawer/student_drawer_view.dart';

class StudentDrawerContent extends StatefulWidget {
  const StudentDrawerContent({super.key, required this.userId});
  final String? userId;

  @override
  State<StudentDrawerContent> createState() => _StudentDrawerContentState();
}

class _StudentDrawerContentState extends State<StudentDrawerContent> {
  late final StudentDrawerView studentDrawerView;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    studentDrawerView = StudentDrawerView();
    studentDrawerView.pagesCreate(widget.userId!);
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: Theme.of(context).brightness == Brightness.dark
          ? Colors.black.withOpacity(0.8) // Dark Mode için
          : Colors.white.withOpacity(0.9), // Light Mode için
      slidePercent: 40,
      initPositionSelected: 0,
      contentCornerRadius: 20,
      elevationAppBar: 0,
      withShadow: true,
      isTitleCentered: true,
      boxShadow: [
        if (Theme.of(context).brightness == Brightness.light) ...[
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Açık temada hafif gölge
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ] else ...[
          BoxShadow(
            color: Colors.black
                .withOpacity(0.3), // Koyu temada daha belirgin gölge
            blurRadius: 15,
            spreadRadius: 3,
            offset: Offset(0, 6),
          ),
        ],
      ],
      leadingAppBar: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Image.asset(
          'assets/icons/menu.png',
          color: Theme.of(context).iconTheme.color,
        ),
      ),

      actionsAppBar: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon: Image.asset(
              'assets/icons/ring.png',
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {},
          ),
        ),
      ],
      screens: studentDrawerView.pages.value,
    );
  }
}
