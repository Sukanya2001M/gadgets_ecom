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

  Future<Map<String, dynamic>> call(int productId, double price, String color) {
    return repositories.updateProduct(productId, price, color);
  }

  Future<Map<String, dynamic>> execute(Map<String, dynamic> productData) async {
    return await repositories.createProduct(productData);
  }
}
