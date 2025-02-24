import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gadgets_ecom/Data/Model/Model.dart';
import 'package:gadgets_ecom/Domain/UseCase/Usecase.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  final RxList<Model> products = <Model>[].obs;
  final RxList<String> name = <String>[].obs;
  final RxList<String> data = <String>[].obs;
  var liked = <bool>[].obs;
  var isEditing = <bool>[].obs;
  final RxList<TextEditingController> nameControllers =
      <TextEditingController>[].obs;
  final RxList<TextEditingController> dataControllers =
      <TextEditingController>[].obs;

  final Usecases usecase;
  Controller(this.usecase);

  Future<void> fetchProduct() async {
    try {
      dynamic response = await usecase.fetchProductusr();

      if (response.isNotEmpty) {
        List<Model> productList =
            response.map<Model>((item) => Model.fromJson(item)).toList();

        products.assignAll(productList);
        name.assignAll(productList.map((product) => product.name).toList());
        data.assignAll(productList.map((product) {
          if (product.data == null) {
            return 'N/A';
          }
          return product.data!.entries
              .map((e) => '${e.key}: ${e.value}')
              .join(', ');
        }).toList());

        // Initialize lists
        liked.assignAll(List.generate(productList.length, (_) => false));
        isEditing.assignAll(List.generate(productList.length, (_) => false));
        nameControllers.assignAll(List.generate(
            name.length, (index) => TextEditingController(text: name[index])));
        dataControllers.assignAll(List.generate(
            data.length, (index) => TextEditingController(text: data[index])));
      } else {
        print('Empty response from controller');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void toggleFavorite(int index) {
    liked[index] = !liked[index];
  }

  void enableEditing(int index) {
    isEditing[index] = true;
    isEditing.refresh(); // Force UI update
    print("Editing enabled for index: $index");
  }

  Future<void> updateProduct(int index) async {
    final updatedName = nameControllers[index].text;
    final updatedData = dataControllers[index].text;

    // Example parsing of data to extract values
    final updatedParts = updatedData.split(", ");
    String color = "white"; // Default color
    String generation = "";
    int price = 0;

    for (var part in updatedParts) {
      if (part.contains("Gen")) {
        generation = part;
      } else if (part.contains("Price")) {
        price = int.tryParse(part.split(":")[1].trim()) ?? 0;
      }
    }

    final payload = jsonEncode({
      "name": updatedName,
      "data": {"color": color, "generation": generation, "price": price}
    });

    final url = Uri.parse("https://api.restful-api.dev/objects/6");
    final headers = {"Content-Type": "application/json"};

    try {
      final response = await http.put(url, body: payload, headers: headers);

      if (response.statusCode == 200) {
        // Successfully updated
        name[index] = updatedName;
        data[index] = updatedData;
        isEditing[index] = false;
      } else {
        print("Update failed: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
