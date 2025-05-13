import '../../../../export.dart';

class TabBarItem extends StatelessWidget {
  final String tabBarTitle;
  const TabBarItem({
    super.key,
    required this.tabBarTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Padding(
        padding: WidgetSizes.smallPadding.value,
        child: Text(
          tabBarTitle,
        ),
      ),
    );
  }
}
