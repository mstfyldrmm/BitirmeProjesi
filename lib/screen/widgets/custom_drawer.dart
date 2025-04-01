import 'package:qr_attendance_project/export.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [
      screenHiddenDrawerMethod(title: 'Ana Sayfa', widget: TeacherMainScreen()),
      screenHiddenDrawerMethod(title: 'Taleplerim', widget: SizedBox.shrink()),
      screenHiddenDrawerMethod(
          title: 'Hesabım', widget: StudentAccountScreen()),
    ];
  }

  ScreenHiddenDrawer screenHiddenDrawerMethod(
      {required String title, required Widget widget}) {
    return ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: title,
          baseStyle: textStyleUnselected(),
          selectedStyle: textStyle(),
        ),
        widget);
  }

  TextStyle textStyle() => TextStyle(fontWeight: FontWeight.bold, fontSize: 24);
  TextStyle textStyleUnselected() =>
      TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

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
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: () {},
          ),
        ),
      ],
      screens: _pages,
    );
  }
}
