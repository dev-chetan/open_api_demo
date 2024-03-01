import 'package:flutter/material.dart';
import 'package:open_api_demo/enums.dart';
import 'package:petstore_api/src/model/pet.dart';

import '../get_cls/pet_store_controler.dart';
import 'package:get/get.dart';

import '../utils/app_strings.dart';
import '../widgets/app_error_widget.dart';

class PetScreen extends StatefulWidget {
  const PetScreen({super.key});

  @override
  State<PetScreen> createState() => _PetScreenState();
}

class _PetScreenState extends State<PetScreen> {
  PetStoreController controller = Get.put(PetStoreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Obx(() => FloatingActionButton(
              onPressed: () => controller.addResponseStatus == ApiStatus.loading
                  ? () {}
                  : controller.addPet(),
              child: controller.addResponseStatus == ApiStatus.loading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                  : Icon(Icons.add),
            )),
        appBar: AppBar(title: Text(txtPetList.toUpperCase())),
        body: Obx(() => controller.responseStatus == ApiStatus.loading
            ? Center(child: CircularProgressIndicator())
            : controller.responseStatus == ApiStatus.content
                ? _ListSection(
                    listData: controller.petList.value, controller: controller)
                : AppErrorWidget(
                    msg: controller.responseError.value,
                    onRetry: () => controller.getPetsList(),
                  )));
  }
}

class _ListSection extends StatelessWidget {
  final List<Pet> listData;
  final PetStoreController controller;

  const _ListSection(
      {super.key, required this.listData, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        itemCount: listData.length,
        itemBuilder: (BuildContext context, int index) {
          var data = listData[index];
          return _ListItemWidget(
            data: data,
            onTap: (data) => controller.updatePet(data.id!, data),
            onDelete: (Pet data) => controller.deletePet(data.id!, data),
          );
        });
  }
}

class _ListItemWidget extends StatelessWidget {
  final Pet data;
  final Null Function(Pet data) onTap;
  final Null Function(Pet data) onDelete;

  const _ListItemWidget({
    super.key,
    required this.data,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                    child: Text('update'.toString()),
                    onTap: () {
                      onTap(data);
                    }),
                SizedBox(width: 6),
                InkWell(
                  child: Icon(Icons.delete, color: Colors.red),
                  onTap: () {
                    onDelete(data);
                  },
                )
              ],
            ),
            title: Text(data.name),
            subtitle: data.category != null
                ? Text(data.category!.name ?? '')
                : null));
  }
}
