import 'package:get_it/get_it.dart';
import 'package:qr_attendance_project/services/ogrenci_services.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(() => OgrenciServices());
}