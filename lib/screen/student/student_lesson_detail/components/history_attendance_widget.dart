import 'package:qr_attendance_project/export.dart';


class AttendanceHistoryWidget extends StatelessWidget {
  const AttendanceHistoryWidget({
    super.key,
  });

  //Veriler elle olusturuldu. Daha sonra page view builder ile düzeltilecek ve components eklenecek.
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Theme.of(context).primaryColor,
      child: Column(
        children: [
          EmptyWidget(),
          Expanded(
            child: Text(
              LocaleKeys.studentLessonDetail_pastAttendance.locale,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Expanded(
            flex: 7,
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CustomIconCreator(
                      iconPath: 'assets/icons/approved.png',
                      iconColor:
                          Theme.of(context).hintColor.withValues(alpha: 1)),
                  title: Text(
                    'Mikroişlemciler',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    '${sampleStudentAttendanceList[index].studentAttendanceDate}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing:
                      CustomIconCreator(iconPath: 'assets/icons/accept.png'),
                ); // Her bir öğe
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Theme.of(context).hintColor.withValues(alpha: 1),
                );
              },
              itemCount: sampleStudentAttendanceList.length,
            ),
          )
        ],
      ),
    );
  }
}

List<StudentAttendanceModel> sampleStudentAttendanceList = [
  StudentAttendanceModel(
    studentId: "1001",
    studentName: "Ahmet",
    studentSurname: "Yılmaz",
    studentClass: "2. Sınıf",
    studentClassId: "CSE202",
    studentAttendanceStatus: "Katıldı",
    studentAttendanceDate: "2025-03-25",
  ),
  StudentAttendanceModel(
    studentId: "1001",
    studentName: "Ahmet",
    studentSurname: "Yılmaz",
    studentClass: "2. Sınıf",
    studentClassId: "CSE202",
    studentAttendanceStatus: "Katılmadı",
    studentAttendanceDate: "2025-03-26",
  ),
  StudentAttendanceModel(
    studentId: "1001",
    studentName: "Ahmet",
    studentSurname: "Yılmaz",
    studentClass: "2. Sınıf",
    studentClassId: "CSE202",
    studentAttendanceStatus: "Katıldı",
    studentAttendanceDate: "2025-03-27",
  ),
  StudentAttendanceModel(
    studentId: "1001",
    studentName: "Ahmet",
    studentSurname: "Yılmaz",
    studentClass: "2. Sınıf",
    studentClassId: "CSE202",
    studentAttendanceStatus: "Katıldı",
    studentAttendanceDate: "2025-03-28",
  ),
  StudentAttendanceModel(
    studentId: "1001",
    studentName: "Ahmet",
    studentSurname: "Yılmaz",
    studentClass: "2. Sınıf",
    studentClassId: "CSE202",
    studentAttendanceStatus: "Katılmadı",
    studentAttendanceDate: "2025-03-29",
  ),
  StudentAttendanceModel(
    studentId: "1001",
    studentName: "Ahmet",
    studentSurname: "Yılmaz",
    studentClass: "2. Sınıf",
    studentClassId: "CSE202",
    studentAttendanceStatus: "Katıldı",
    studentAttendanceDate: "2025-03-30",
  ),
  StudentAttendanceModel(
    studentId: "1001",
    studentName: "Ahmet",
    studentSurname: "Yılmaz",
    studentClass: "2. Sınıf",
    studentClassId: "CSE202",
    studentAttendanceStatus: "Katıldı",
    studentAttendanceDate: "2025-03-31",
  ),
  StudentAttendanceModel(
    studentId: "1001",
    studentName: "Ahmet",
    studentSurname: "Yılmaz",
    studentClass: "2. Sınıf",
    studentClassId: "CSE202",
    studentAttendanceStatus: "Katıldı",
    studentAttendanceDate: "2025-04-01",
  ),
  StudentAttendanceModel(
    studentId: "1001",
    studentName: "Ahmet",
    studentSurname: "Yılmaz",
    studentClass: "2. Sınıf",
    studentClassId: "CSE202",
    studentAttendanceStatus: "Katılmadı",
    studentAttendanceDate: "2025-04-02",
  ),
  StudentAttendanceModel(
    studentId: "1001",
    studentName: "Ahmet",
    studentSurname: "Yılmaz",
    studentClass: "2. Sınıf",
    studentClassId: "CSE202",
    studentAttendanceStatus: "Katıldı",
    studentAttendanceDate: "2025-04-03",
  ),
];
