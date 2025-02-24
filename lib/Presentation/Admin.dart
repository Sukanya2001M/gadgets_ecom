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
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Enter Product Details"),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: controller.nameControllerad,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(labelText: "Name"),
                        ),
                        TextFormField(
                          controller: controller.yearController,
                          decoration: InputDecoration(labelText: "Year"),
                          keyboardType: TextInputType.number,
                        ),
                        TextFormField(
                          controller: controller.priceController,
                          decoration: InputDecoration(labelText: "Price"),
                          keyboardType: TextInputType.number,
                        ),
                        TextFormField(
                          controller: controller.cpuController,
                          decoration: InputDecoration(labelText: "CPU Model"),
                        ),
                        TextFormField(
                          controller: controller.diskController,
                          decoration:
                              InputDecoration(labelText: "Hard Disk Size"),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.addproductctr(
                            controller.nameControllerad.text, // String
                            int.tryParse(controller.yearController.text) ??
                                0, // Convert String to int
                            int.tryParse(controller.priceController.text) ??
                                0, // Convert String to int
                            controller.cpuController.text, // String
                            controller.diskController.text // String
                            );
                        Navigator.of(context).pop();
                      },
                      child: Text("Submit"),
                    ),
                  ],
                );
              },
            );
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
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Product Name
                                controller.isEditing[index]
                                    ? TextField(
                                        controller:
                                            controller.nameController[index],
                                        decoration: const InputDecoration(
                                          labelText: "Product Name",
                                          border: OutlineInputBorder(),
                                        ),
                                      )
                                    : Text(
                                        controller.name[index],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                const SizedBox(height: 10),

                                // Year
                                controller.isEditing[index]
                                    ? TextField(
                                        controller: controller.yearController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          labelText: "Year",
                                          border: OutlineInputBorder(),
                                        ),
                                      )
                                    : Text(
                                        "Year: ${controller.products[index].data?['year'] ?? 'N/A'}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54),
                                      ),
                                const SizedBox(height: 8),

                                // Price
                                controller.isEditing[index]
                                    ? TextField(
                                        controller: controller.priceController,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        decoration: const InputDecoration(
                                          labelText: "Price",
                                          border: OutlineInputBorder(),
                                        ),
                                      )
                                    : Text(
                                        "Price: \$${controller.products[index].data?['price'] ?? 'N/A'}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54),
                                      ),
                                const SizedBox(height: 8),

                                // CPU Model
                                controller.isEditing[index]
                                    ? TextField(
                                        controller: controller.cpuController,
                                        decoration: const InputDecoration(
                                          labelText: "CPU Model",
                                          border: OutlineInputBorder(),
                                        ),
                                      )
                                    : Text(
                                        "CPU: ${controller.products[index].data?['CPU model'] ?? 'N/A'}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54),
                                      ),
                                const SizedBox(height: 8),

                                // Hard Disk Size
                                controller.isEditing[index]
                                    ? TextField(
                                        controller: controller.diskController,
                                        decoration: const InputDecoration(
                                          labelText: "Hard Disk Size",
                                          border: OutlineInputBorder(),
                                        ),
                                      )
                                    : Text(
                                        "Hard Disk: ${controller.products[index].data?['Hard disk size'] ?? 'N/A'}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54),
                                      ),
                                const SizedBox(height: 8),

                                // Color
                                controller.isEditing[index]
                                    ? TextField(
                                        controller: controller.nameControllerad,
                                        decoration: const InputDecoration(
                                          labelText: "Color",
                                          border: OutlineInputBorder(),
                                        ),
                                      )
                                    : Text(
                                        "Color: ${controller.products[index].data?['color'] ?? 'N/A'}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54),
                                      ),

                                const SizedBox(height: 12),

                                // Action Buttons
                                Obx(() {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
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
                                            controller.updateproductctr(
                                              controller
                                                  .nameController[index].text,
                                              int.tryParse(controller
                                                      .yearController.text) ??
                                                  0, // Convert to int
                                              double.tryParse(controller
                                                      .priceController.text) ??
                                                  0.0,
                                              controller.cpuController.text,
                                              controller.diskController.text,
                                              controller.colorController.text,
                                            );
                                          } else {
                                            controller.enableEditing(index);
                                          }
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () {
                                          controller.deleteporoductctr();
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.timelapse_sharp,
                                            color: Colors.orange),
                                        onPressed: () {
                                          // Time-based function here
                                        },
                                      ),
                                    ],
                                  );
                                }),
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
