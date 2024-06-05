import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onlineshopbasmida/allproductlist.dart';

class EditProduct extends StatefulWidget {
  final Map products;
  const EditProduct({Key? key, required this.products}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _name = TextEditingController();
  final _price = TextEditingController();
  final _description = TextEditingController();
  final _promo = TextEditingController();
  final _images = TextEditingController();

  @override
  void initState() {
    super.initState();
    _name.text = widget.products['name'];
    _price.text = widget.products['price'];
    _description.text = widget.products['description'];
    _promo.text = widget.products['promo'];
    _images.text = widget.products['images'];
  }

  Future<void> updateProduct() async {
    String urlUpdateProduct =
        'https://basmida09laia.000webhostapp.com/updateproduct.php';

    try {
      final responseUpdate = await http.post(Uri.parse(urlUpdateProduct), body: {
        "id": widget.products['id'],
        "name": _name.text.toString(),
        "price": _price.text.toString(),
        "description": _description.text.toString(),
        "promo": _promo.text.toString(),
        "images": _images.text.toString()
      });

      var updateProduct = jsonDecode(responseUpdate.body);
      if (updateProduct == "true") {
        print("Product successfully updated");
              
      } else {
        print("Failed to update product");
      }
    } catch (exc) {
      print(exc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AllProduct()),
            );
          },
        ),
        title: const Text(
          'Edit Product',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green.shade400,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 20, 30, 10),
              child: TextField(
                controller: _name,
                autocorrect: true,
                decoration: InputDecoration(
                  labelText: "Product Name: ",
                  hintText: "Enter Product Name",
                  labelStyle: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                  prefixIcon: Icon(
                    Icons.shopping_bag,
                    color: Colors.amber,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                          color: Colors.green.shade300),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 30, 10),
              child: TextField(
                controller: _price,
                autocorrect: true,
                decoration: InputDecoration(
                  labelText: "Price: ",
                  hintText: "Enter Price ",
                  labelStyle: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                  prefixIcon: Icon(
                    Icons.attach_money,
                    color: Colors.amber,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                          color: Colors.green.shade300),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 30, 10),
              child: TextField(
                controller: _description,
                autocorrect: true,
                decoration: InputDecoration(
                  labelText: "Description : ",
                  hintText: "Enter Description ",
                  labelStyle: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                  prefixIcon: Icon(
                    Icons.add_comment_outlined,
                    color: Colors.amber,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                          color: Colors.green.shade300),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 30, 10),
              child: TextField(
                controller: _promo,
                autocorrect: true,
                decoration: InputDecoration(
                  labelText: "Promo: ",
                  hintText: "Enter Promo",
                  labelStyle: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                  prefixIcon: Icon(
                    Icons.local_offer,
                    color: Colors.amber,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                          color:
                      Colors.green.shade300
                      ),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 30, 5),
              child: TextField(
                controller: _images,
                autocorrect: true,
                decoration: InputDecoration(
                  labelText: "Images URL : ",
                  hintText: "Enter URL Images ",
                  labelStyle: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                  prefixIcon: Icon(
                    Icons.image,
                    color: Colors.amber,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                          color: Colors.green.shade300),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(40),
              child: ElevatedButton(
                onPressed: () {
                  updateProduct();
                   Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AllProduct()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product successfully updated'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green.shade300,
          ),
        );
                },
                child: Text(
                  "Update Product",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade400,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}