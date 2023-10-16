import 'package:flutter/material.dart';

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:const Text('Add New Product')),
      body:SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.all(16),
          child:Column(
            children:[
              const TextField(
                decoration:InputDecoration(
                  hintText:'Enter product name',
                  border:OutlineInputBorder()
                )
              ),
              const SizedBox(height:16),
              const TextField(
                decoration:InputDecoration(
                  hintText:'Product description',
                  border:OutlineInputBorder()
                )
              ),
              const SizedBox(height:16),
              const TextField(
                decoration:InputDecoration(
                  hintText:'Unit price',
                  border:OutlineInputBorder()
                ),
                keyboardType:TextInputType.number,
              ),
              const SizedBox(height:16),
              const TextField(
                decoration:InputDecoration(
                  hintText:'Image url',
                  border:OutlineInputBorder()
                )
              ),
              const SizedBox(height:16),
              SizedBox(
                width:double.infinity,
                child: ElevatedButton(
                  onPressed:(){print("Add button clicked!");},
                  style:ElevatedButton.styleFrom(
                    padding:const EdgeInsets.symmetric(vertical:15)
                  ),
                  child:const Text('Add'),
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}
