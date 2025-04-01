import 'package:get_it/get_it.dart';
import 'package:qr_attendance_project/services/service_local_storage.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async{
  locator.registerLazySingleton(ServiceLocalStorage.new);
}
