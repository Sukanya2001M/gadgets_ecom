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
  final RxList<TextEditingController> nameController =
      <TextEditingController>[].obs;
  final RxList<TextEditingController> dataController =
      <TextEditingController>[].obs;
  final TextEditingController nameControllerad = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController cpuController = TextEditingController();
  final TextEditingController diskController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
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

        liked.assignAll(List.generate(productList.length, (_) => false));
        isEditing.assignAll(List.generate(productList.length, (_) => false));
        nameController.assignAll(
            List.generate(productList.length, (_) => TextEditingController()));
        dataController.assignAll(
            List.generate(productList.length, (_) => TextEditingController()));
        // print('controller,${response}');
      } else {
        print('Empty response from controller');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
    update();
  }

  void toggleFavorite(int index) {
    liked[index] = !liked[index];
  }

  void enableEditing(int index) {
    isEditing[index] = true;
    isEditing.refresh(); // Force UI update
    print("Editing enabled for index: $index");
  }

  Future<dynamic> addproductctr(String name, int year, int price,
      String cpumodel, String harddisk) async {
    try {
      dynamic response =
          await usecase.addProductusr(name, year, price, cpumodel, harddisk);
      if (response != null) {
        // Convert response to Model instance
        Model newProduct = Model.fromJson(response);

        // Add new product to the list
        products.add(newProduct);

        // Update UI with new product
        this.name.add(newProduct.name);
        this.data.add(newProduct.data != null
            ? newProduct.data!.entries
                .map((e) => '${e.key}: ${e.value}')
                .join(', ')
            : 'N/A');

        liked.add(false);
        isEditing.add(false);

        // print("Product added successfully: ${newProduct.name}");
      } else {
        print("Failed to add product");
      }

      return response;
    } catch (e) {
      print('Error add data: $e');
    }
  }

  Future<void> updateproductctr(String name, int year, double price,
      String cpumodel, String harddisk, String color) async {
    try {
      dynamic response = await usecase.updateproductusr(
          name, year, price, cpumodel, harddisk, color);
      if (response != null) {
        // Convert response to Model instance
        Model newProduct = Model.fromJson(response);

        // Add new product to the list
        products.add(newProduct);

        // Update UI with new product
        this.name.add(newProduct.name);
        this.data.add(newProduct.data != null
            ? newProduct.data!.entries
                .map((e) => '${e.key}: ${e.value}')
                .join(', ')
            : 'N/A');

        liked.add(false);
        isEditing.add(false);
        // print("Product added successfully: ${newProduct.name}");
      } else {
        print("Failed to add product");
      }
      print('controller ${response}');
    } catch (e) {
      print("Error in updating ctr $e");
    }
  }

  Future<String?> deleteporoductctr() async {
    try {
      String? response = await usecase.deleteproductusr();

      if (response != null) {
        print("Controller delete: $response");
        return response;
      } else {
        print("Delete failed at controller level.");
        return null;
      }
    } catch (e) {
      print("Error in controller delete: $e");
      return null;
    }
  }
}
