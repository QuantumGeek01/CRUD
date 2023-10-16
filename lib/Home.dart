import 'package:flutter/material.dart';
import 'Product_details.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CRUD")),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const Product()));
          },
          child: const Icon(Icons.add)),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (Context, index) {
            return ListTile(
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Choose an action'),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.close),
                            )
                          ],
                        ),
                        content: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                                title: Text('Edit'), leading: Icon(Icons.edit)),
                            ListTile(
                                title: Text('Delete'),
                                leading: Icon(Icons.delete))
                          ],
                        ),
                      );
                    },
                    barrierDismissible: false);
              },
              title: Text('Product name'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Product code'),
                  Text('Total price'),
                  Text('Available unit'),
                ],
              ),
              leading: Image.network(
                  "https://media-ik.croma.com/prod/https://media.croma.com/image/upload/v1664425037/Croma%20Assets/Computers%20Peripherals/Laptop/Images/256967_0_c0izmj.png?tr=w-1000",
                  errorBuilder: (_, __, ___) {
                return const Icon(Icons.image, size: 30);
              }),
              trailing: Text('Unit price'),
            );
          }),
    );
  }
}
