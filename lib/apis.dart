import 'dart:ffi';

import 'package:built_collection/src/list.dart';
import 'package:dio/dio.dart';
import 'package:open_api_demo/utils/app_constants.dart';
import 'package:open_api_demo/utils/base_response.dart';
import 'package:petstore_api/petstore_api.dart';

class Apis {
  PetApi _petApi() => PetApi(
      Dio(BaseOptions(baseUrl: 'https://petstore3.swagger.io/api/v3')),
      standardSerializers);

  /// Get pet list...
  Future<BaseResponse<List<Pet>>> getPetList() async {
    var findPetsByStatus =
        await _petApi().findPetsByStatus(status: 'available');
    if (findPetsByStatus.statusCode == AppConstant.successCode) {
      return BaseResponse(findPetsByStatus.data!.toList(), null);
    } else {
      return BaseResponse(null, findPetsByStatus.statusMessage);
    }
  }

  /// Add pet...
  Future<BaseResponse<Pet>> addPet() async {
    var pet1 = Pet((b) => b
      ..name = 'Cat'
      ..status = PetStatusEnum.available
      ..photoUrls = ListBuilder<String>(['item2']));
    var findPetsByStatus;
    try {
      findPetsByStatus = await _petApi().addPet(pet: pet1);
    } catch (error, stackTrace) {
      return BaseResponse(null, error.toString());
    }
    if (findPetsByStatus.statusCode == AppConstant.successCode) {
      return BaseResponse(findPetsByStatus.data!, null);
    } else {
      return BaseResponse(null, findPetsByStatus.statusMessage);
    }
  }

  /// Update pet...
  Future<BaseResponse<Void>> updatePet(int petId, Pet data) async {
    var findPetsByStatus;
    try {
      var pet1 = Pet((b) => b
        ..name = '${data.name} ${petId}'
        ..id = data.id
        ..status = PetStatusEnum
            .available /*..photoUrls = ListBuilder<String>(['item2'])*/);

      findPetsByStatus = await _petApi().updatePet(pet: pet1);
    } catch (error, stackTrace) {
      return BaseResponse(null, error.toString());
    }
    if (findPetsByStatus.statusCode == AppConstant.successCode) {
      return BaseResponse(null, null);
    } else {
      return BaseResponse(null, findPetsByStatus.statusMessage);
    }
  }

  /// Update pet...
  Future<BaseResponse<void>> deletePet(int petId, Pet data) async {
    var findPetsByStatus;
    try {
      findPetsByStatus = await _petApi().deletePet(petId: petId);
    } catch (error, stackTrace) {
      return BaseResponse(null, error.toString());
    }
    if (findPetsByStatus.statusCode == AppConstant.successCode) {
      return BaseResponse(null, null);
    } else {
      return BaseResponse(null, findPetsByStatus.statusMessage);
    }
  }
}
