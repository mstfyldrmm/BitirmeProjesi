import 'package:qr_attendance_project/export.dart';

class PopupLessonSelector extends StatelessWidget {
  const PopupLessonSelector({
    super.key,
    required this.lessons,
    required this.selectedLesson,
    required this.onSelected,
    this.validator,
  });

  final List<String?> lessons;
  final ValueListenable<String> selectedLesson;
  final ValueChanged<String> onSelected;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    final filteredLessons = lessons
        .where((e) => e != null && e!.trim().isNotEmpty)
        .map((e) => e!.trim())
        .toSet()
        .toList();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: FormField<String>(
        validator: validator,
        builder: (field) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PopupMenuButton<String>(
                position: PopupMenuPosition.under,
                menuPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                onSelected: (value) {
                  onSelected(value);
                  field.didChange(value); // FormField kontrolü için gerekli
                },
                itemBuilder: (context) => filteredLessons.map((lesson) {
                  return PopupMenuItem<String>(
                    textStyle: Theme.of(context).textTheme.titleMedium,
                    labelTextStyle: WidgetStatePropertyAll(
                      Theme.of(context).textTheme.titleMedium,
                    ),
                    value: lesson,
                    child: Text(lesson),
                  );
                }).toList(),
                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: ValueListenableBuilder<String>(
                    valueListenable: selectedLesson,
                    builder: (context, value, _) {
                      return Text(
                        value.isNotEmpty
                            ? value
                            : LocaleKeys.studentRequest_selectLesson.locale,
                        style: Theme.of(context).textTheme.titleMedium,
                      );
                    },
                  ),
                  trailing: const Icon(Icons.arrow_drop_down),
                  contentPadding: const EdgeInsets.only(left: 20),
                ),
              ),
              if (field.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 12),
                  child: Text(
                    field.errorText!,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
