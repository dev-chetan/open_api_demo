// Openapi Generator last run: : 2024-02-29T23:26:09.288633
import 'package:flutter/material.dart';
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';
import 'package:get/get.dart';
import 'layouts/pet_screen.dart';

void main() {
  runApp(const MyApp());
}

@Openapi(
  additionalProperties:
      DioProperties(pubName: 'petstore_api', pubAuthor: 'Chetan Raval'),
  inputSpec:
      RemoteSpec(path: 'https://petstore3.swagger.io/api/v3/openapi.json'),
  generatorName: Generator.dio,
  runSourceGenOnOutput: true,
  outputDirectory: 'api/petstore_api',
)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue), home: PetScreen());
  }
}
