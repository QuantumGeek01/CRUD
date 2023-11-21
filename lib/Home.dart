import 'dart:convert';
import 'package:flutter/material.dart';
import 'AddProduct.dart';
import 'package:http/http.dart';
import 'product_details.dart';
import 'update_product.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ProductDetails> products = [];
  bool inProgress = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct();
  }

  getProduct() async {
    inProgress = true;
    setState(() {});
    Response response =
        await get(Uri.parse('https://crud.teamrabbil.com/api/v1/ReadProduct'));
    print(response.body);

    Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200 && decodedResponse['status'] == "success") {
      decodedResponse['data'].forEach((e) {
        products.add(ProductDetails.toAdd(e));
      });
    }
    inProgress = false;
    setState(() {});
  }

  deleteProduct(String id) async {
    inProgress = true;
    setState(() {});
    Response response = await get(
        Uri.parse('https://crud.teamrabbil.com/api/v1/DeleteProduct/$id'));

    Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200 && decodedResponse['status'] == "success") {
      products.clear();
      getProduct();
    } else {
      inProgress = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CRUD"), actions: [
        IconButton(
            onPressed: () {
              products.clear();
              getProduct();
            },
            icon: const Icon(Icons.refresh))
      ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const Product()));
          },
          child: const Icon(Icons.add)),
      body: inProgress
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
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
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  onTap:(){
                                    Navigator.pop(context);
                                    Navigator.push(context,MaterialPageRoute(builder:(C)=>UpdateProduct(product:products[index])));
                                  },
                                    title:const Text('Edit'),
                                    leading: const Icon(Icons.edit)),
                                ListTile(
                                    onTap: () {
                                      deleteProduct(products[index].id);
                                      Navigator.pop(context);
                                    },
                                    title: const Text('Delete'),
                                    leading: const Icon(Icons.delete))
                              ],
                            ),
                          );
                        },
                        barrierDismissible: false);
                  },
                  title: Text(products[index].productName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('code: ${products[index].productCode}'),
                      Text('qty: ${products[index].qty}'),
                      Text('total price: ${products[index].totalPrice}\$'),
                    ],
                  ),
                  leading: Image.network(products[index].image, width: 50,
                      errorBuilder: (_, __, ___) {
                    return const Icon(Icons.image, size: 30);
                  }),
                  trailing: Text("${products[index].unitPrice}\$/p"),
                );
              }),
    );
  }
}
