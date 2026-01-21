import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DataModule {

  @lazySingleton
  GetStorage get getStorage => GetStorage();
}
