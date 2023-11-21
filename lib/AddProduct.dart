import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _productCodeTextEditingController =
      TextEditingController();
  final TextEditingController _priceTextEditingController =
      TextEditingController();
  final TextEditingController _quantityTextEditingController =
      TextEditingController();
  final TextEditingController _totalPriceTextEditingController =
      TextEditingController();
  final TextEditingController _imgTextEditingController =
      TextEditingController();

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  postProduct() async {
    Response response = await post(
        Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct'),
        headers: {'content-type': 'application/json'},
        body: jsonEncode({
          "Img": _imgTextEditingController.text,
          "ProductCode": _productCodeTextEditingController.text,
          "ProductName": _nameTextEditingController.text,
          "Qty": _quantityTextEditingController.text,
          "TotalPrice": _totalPriceTextEditingController.text,
          "UnitPrice": _priceTextEditingController.text
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Product')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formState,
            child: Column(children: [
              TextFormField(
                controller: _nameTextEditingController,
                decoration: const InputDecoration(
                    hintText: 'Enter product name',
                    border: OutlineInputBorder()),
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter product name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _productCodeTextEditingController,
                decoration: const InputDecoration(
                    hintText: 'Product code', border: OutlineInputBorder()),
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter product code';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceTextEditingController,
                decoration: const InputDecoration(
                    hintText: 'Unit price', border: OutlineInputBorder()),
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter Unit price';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _quantityTextEditingController,
                decoration: const InputDecoration(
                    hintText: 'Quantity', border: OutlineInputBorder()),
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter quantity';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _totalPriceTextEditingController,
                decoration: const InputDecoration(
                    hintText: 'Total price', border: OutlineInputBorder()),
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter total price';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _imgTextEditingController,
                decoration: const InputDecoration(
                    hintText: 'Image url', border: OutlineInputBorder()),
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter Url';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formState.currentState!.validate()) {
                      postProduct();
                      _priceTextEditingController.clear();
                      _totalPriceTextEditingController.clear();
                      _quantityTextEditingController.clear();
                      _nameTextEditingController.clear();
                      _productCodeTextEditingController.clear();
                      _imgTextEditingController.clear();

                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15)),
                  child: const Text('Add'),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
