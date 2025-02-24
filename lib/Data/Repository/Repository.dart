import 'package:dio/dio.dart';
import 'package:gadgets_ecom/Data/Constants/Constants.dart';

class Repositories {
  final Dio dio = Dio();

  Future<dynamic> fetchProductrepo() async {
    try {
      var response = await dio.get(Constants.allproduct_url);
      // print('repository ${response.data}');
      return response.data;
    } catch (e) {
      print('Error fetching profile details: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>> updateProduct(
      int productId, double price, String color) async {
    final String url = "$Constants.baseUrl/$productId";

    final Map<String, dynamic> productData = {
      "name": "Apple AirPods",
      "data": {"generation": "3rd", "price": price, "color": color}
    };

    try {
      Response response = await dio.put(
        url,
        data: productData,
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Failed to update product: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Error updating product: ${e.message}");
    }
  }

  Future<Map<String, dynamic>> createProduct(
      Map<String, dynamic> productData) async {
    try {
      Response response = await dio.post("objects", data: productData);
      return response.data;
    } catch (e) {
      print("Error creating product: $e");
      throw Exception("Failed to create product");
    }
  }
}
