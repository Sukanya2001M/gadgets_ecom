import 'package:gadgets_ecom/Data/Repository/Repository.dart';
import 'package:gadgets_ecom/Domain/UseCase/Usecase.dart';
import 'package:gadgets_ecom/Presentation/Controller/Controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Repositories>(() => Repositories(), fenix: true);
    Get.lazyPut<Usecases>(() => Usecases(Get.find<Repositories>()),
        fenix: true);
    Get.lazyPut<Controller>(() => Controller(Get.find<Usecases>()),
        fenix: true);
  }
}
