import 'package:dio/dio.dart';
import 'package:gadgets_ecom/Data/Constants/Constants.dart';

class Repositories {
  final Dio dio = Dio();

  Future<dynamic> fetchProductrepo() async {
    try {
      var response = await dio.get(Constants.allproduct_url);
      // print('repository all ${response.data}');
      return response.data;
    } catch (e) {
      print('Error fetching profile details: $e');
      return null;
    }
  }

  Future<dynamic> addProductrepo(
    String name,
    int year,
    int price,
    String cpumodel,
    String harddisk,
  ) async {
    try {
      var response = await dio.post(
        Constants.add_url,
        data: {
          "name": name,
          "data": {
            "year": year,
            "price": price,
            "cpu_model": cpumodel,
            "hard_disk": harddisk,
          }
        },
      );
      print('repository add ${response.data}');
      return response.data;
    } catch (e) {
      print('Error fetching profile details: $e');
      return null;
    }
  }

  Future<dynamic> updateproductrepo(String name, int year, double price,
      String cpumodel, String harddisk, String color) async {
    try {
      dynamic response = await dio.put(
        Constants.update_url,
        data: {
          "name": name,
          "data": {
            "year": year,
            "price": price,
            "CPU model": cpumodel,
            "Hard disk size": harddisk,
            "color": color,
          }
        },
      );
      print('updated repo $response');
      return response;
    } catch (e) {
      print("Error in updating $e");
      return null;
    }
  }

  Future<String?> deleteproductrepo() async {
    try {
      dynamic response = await dio.delete(Constants.delete_url);
      String message = response.data;
      print("Delete Message: $message");
      return message;
    } catch (e) {
      print("Error in deleting repo: $e");
      return null;
    }
  }
}
