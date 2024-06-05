import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _name = TextEditingController();
  final _price = TextEditingController();
  final _description = TextEditingController();
  final _promo = TextEditingController();
  final _images = TextEditingController();

  void clearText() {
    _name.clear();
    _price.clear();
    _promo.clear();
    _description.clear();
    _images.clear();
  }

  Future<void> addNewProduct() async {
    String urlAddProduct =
        'https://basmida09laia.000webhostapp.com/addproduct.php';
    try {
      final responseAdd = await http.post(Uri.parse(urlAddProduct), body: {
        "name": _name.text.toString(),
        "price": _price.text.toString(),
        "promo": _promo.text.toString(),
        "description" : _description.text.toString(),
        "images": _images.text.toString(),
      });
      
      var addProduct = jsonDecode(responseAdd.body);
      if (addProduct == "true") {
        print("succes");
        
      } else {
        print("failed");
      }
    } catch (exc) {
    print(exc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          "Add Product New",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.notifications, color: Colors.white)
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: _name,
                autocorrect: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.add,
                    color: Colors.amber,
                  ),
                  labelText: "Product Name: ",
                  hintText: "Enter Product Name : ",
                  labelStyle: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          BorderSide(width: 2, style: BorderStyle.solid)),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: _price,
                autocorrect: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.attach_money, color: Colors.amber),
                  labelText: "Price: ",
                  hintText: "Enter Price ",
                  labelStyle: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: 2, style: BorderStyle.solid),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: _promo,
                autocorrect: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.money_off, color: Colors.amber),
                  labelText: "Promo: ",
                  hintText: "Enter promo: ",
                  labelStyle: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          BorderSide(width: 2, style: BorderStyle.solid)),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: _description,
                autocorrect: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.description, color: Colors.amber),
                  labelText: "Description: ",
                  hintText: "Enter Description: ",
                  labelStyle: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          BorderSide(width: 2, style: BorderStyle.solid)),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: _images,
                autocorrect: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.image, color: Colors.amber),
                  labelText: "Image: ",
                  hintText: "Image Url: ",
                  labelStyle: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          BorderSide(width: 2, style: BorderStyle.solid)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(40),
              child: ElevatedButton(
                onPressed: () {
                  addNewProduct();
                  clearText();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(width: 2, style: BorderStyle.solid))),
                child: Text(
                  "Add Product",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
