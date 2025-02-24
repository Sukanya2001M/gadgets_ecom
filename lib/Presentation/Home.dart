import 'package:flutter/material.dart';
import 'package:gadgets_ecom/Presentation/Admin.dart';
import 'package:get/get.dart';
import 'package:gadgets_ecom/Presentation/Controller/Controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  final Controller controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Gadgets Store",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo,
        elevation: 5,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: SizedBox(
        width: 200,
        child: Drawer(
          child: Column(
            children: [
              SizedBox(
                height: 97,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.indigo),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.admin_panel_settings, color: Colors.indigo),
                title: Text('Admin'),
                onTap: () {
                  Get.to(() => AdminScreen()); // Navigate to AdminScreen
                },
              ),
              // ListTile(
              //   leading: Icon(Icons.admin_panel_settings, color: Colors.indigo),
              //   title: Text('Admin1'),
              //   onTap: () {
              //     // Handle tap
              //   },
              // ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
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
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 products per row
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.70, // Adjust height/width ratio
            ),
            itemCount: controller.name.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 222, 219, 219)
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.indigo.withOpacity(0.1),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          child: const Icon(Icons.shopping_bag,
                              size: 60, color: Colors.indigo),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.name[index],
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                controller.data[index],
                                style: const TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: SizedBox(
                      height: 24,
                      width: 90, // Fixed width
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          "Add to cart",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -3,
                    right: 4,
                    child: Obx(() => IconButton(
                          onPressed: () {
                            controller.toggleFavorite(index);
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: controller.liked[index]
                                ? Colors.red
                                : Colors.grey, // Change color dynamically
                            size: 20,
                          ),
                        )),
                  ),
                ],
              );
            },
          ),
        );
      }),
    );
  }
}
