import 'package:flutter/material.dart';
import 'package:gadgets_ecom/Presentation/Home.dart';
import 'package:get/get.dart';
import 'package:gadgets_ecom/Presentation/Controller/Controller.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => AdminScreenState();
}

class AdminScreenState extends State<AdminScreen> {
  final Controller controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          elevation: 5,
          centerTitle: true,
          title: const Text(
            "Gadgets Store",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          ),
        ),
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          onPressed: () {
            // Add new product action
          },
          child: const Icon(Icons.add, size: 28, color: Colors.white),
        ),
        body: Obx(() {
          if (controller.name.isEmpty) {
            return const Center(
              child: Text(
                "No Products Available",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: ListView.builder(
              itemCount: controller.name.length,
              itemBuilder: (context, index) {
                return Obx(() {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 2,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.indigo.withOpacity(0.1),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                          ),
                          child: const Icon(Icons.shopping_bag,
                              size: 60, color: Colors.indigo),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                controller.isEditing[index]
                                    ? TextField(
                                        controller:
                                            controller.nameControllers[index],
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      )
                                    : Text(
                                        controller.name[index],
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.indigo,
                                        ),
                                      ),
                                controller.isEditing[index]
                                    ? TextField(
                                        controller:
                                            controller.dataControllers[index],
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      )
                                    : Text(
                                        controller.data[index],
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.indigo,
                                        ),
                                      ),
                                Obx(() {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          controller.isEditing[index]
                                              ? Icons.save
                                              : Icons.edit,
                                          color: controller.isEditing[index]
                                              ? Colors.green
                                              : Colors.blue,
                                        ),
                                        onPressed: () {
                                          if (controller.isEditing[index]) {
                                            controller.updateProduct(index);
                                          } else {
                                            controller.enableEditing(index);
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                })
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
              },
            ),
          );
        }),
      ),
    );
  }
}
