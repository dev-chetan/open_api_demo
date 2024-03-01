import 'package:open_api_demo/enums.dart';
import 'package:get/get.dart';
import 'package:petstore_api/src/model/pet.dart';

import '../apis.dart';

class PetStoreController extends GetConnect {
  var responseStatus = ApiStatus.loading.obs;
  var responseError = ''.obs;

  var addResponseStatus = ApiStatus.content.obs;

  Apis api = Apis();

  RxList<Pet> petList = RxList<Pet>();

  @override
  void onInit() {
    super.onInit();
    getPetsList();
  }

  getPetsList() {
    responseStatus.value = ApiStatus.loading;
    petList.clear();
    api.getPetList().then((value) {
      if (value.errorResult == null) {
        petList.value = value.data!;
        responseStatus.value = ApiStatus.content;
      } else {
        responseError.value = value.errorResult!;
        responseStatus.value = ApiStatus.error;
      }
    });
  }

  addPet() {
    addResponseStatus.value = ApiStatus.loading;
    api.addPet().then((value) {
      if (value.errorResult == null) {
        addResponseStatus.value = ApiStatus.content;
        Get.snackbar(
          'Success!',
          'Pet ${value.data!.name} added successfully!',
          snackPosition: SnackPosition.BOTTOM,
        );
        getPetsList();
      } else {
        responseError.value = value.errorResult!;
        addResponseStatus.value = ApiStatus.content;
        Get.snackbar('Error!', responseError.value,
            snackPosition: SnackPosition.BOTTOM);
      }
    });
  }

  updatePet(int petId, Pet data) {
    addResponseStatus.value = ApiStatus.loading;
    api.updatePet(petId, data).then((value) {
      if (value.errorResult == null) {
        addResponseStatus.value = ApiStatus.content;
        Get.snackbar(
          'Success!',
          'Pet update successfully!',
          snackPosition: SnackPosition.BOTTOM,
        );
        getPetsList();
      } else {
        responseError.value = value.errorResult!;
        addResponseStatus.value = ApiStatus.content;
        Get.snackbar('Error!', responseError.value,
            snackPosition: SnackPosition.BOTTOM);
      }
    });
  }

  deletePet(int petId, Pet data) {
    addResponseStatus.value = ApiStatus.loading;
    api.deletePet(petId, data).then((value) {
      if (value.errorResult == null) {
        addResponseStatus.value = ApiStatus.content;
        Get.snackbar(
          'Success!',
          'Pet delete successfully!',
          snackPosition: SnackPosition.BOTTOM,
        );
        getPetsList();
      } else {
        responseError.value = value.errorResult!;
        addResponseStatus.value = ApiStatus.content;
        Get.snackbar('Error!', responseError.value,
            snackPosition: SnackPosition.BOTTOM);
      }
    });
  }
}
