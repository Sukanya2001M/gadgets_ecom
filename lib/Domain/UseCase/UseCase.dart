import 'package:gadgets_ecom/Data/Repository/Repository.dart';

class Usecases {
  final Repositories repositories;
  Usecases(this.repositories);

  Future<List<Map<String, dynamic>>> fetchProductusr() async {
    dynamic response = await repositories.fetchProductrepo();
    // print('usecase response: $response');
    if (response is List) {
      return List<Map<String, dynamic>>.from(response);
    } else {
      throw Exception("Unexpected response format: ${response.runtimeType}");
    }
  }

  Future<dynamic> addProductusr(
    String name,
    int year,
    int price,
    String cpumodel,
    String harddisk,
  ) async {
    dynamic response = await repositories.addProductrepo(
      name,
      year,
      price,
      cpumodel,
      harddisk,
    );
    print('usecase add response: $response');
    return response;
  }

  Future<dynamic> updateproductusr(String name, int year, double price,
      String cpumodel, String harddisk, String color) async {
    dynamic response = await repositories.updateproductrepo(
        name, year, price, cpumodel, harddisk, color);
    print('usecase update ${response}');
    return response;
  }

  Future<String?> deleteproductusr() async {
    try {
      String? response = await repositories.deleteproductrepo();

      if (response != null) {
        print("Use case delete: $response");
        return response;
      } else {
        print("Delete failed at use case level.");
        return null;
      }
    } catch (e) {
      print("Error in use case delete: $e");
      return null;
    }
  }
}
