import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onlineshopbasmida/addproduct.dart';
import 'package:onlineshopbasmida/updateproduct.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({super.key});

  @override
  State<AllProduct> createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  List productList = [];
  Future<void> getAllProduct() async {
    String UrlProduct =
        "https://basmida09laia.000webhostapp.com/allproductlist.php";

    try {
      var response = await http.get(Uri.parse(UrlProduct));
      productList = jsonDecode(response.body);
      setState(() {
        productList = jsonDecode(response.body);
      });
    } catch (exc) {
      print(exc);
    }
  }

  Future<void> deleteProduct(String id) async {
    String urlDeleteProduct =
        "https://basmida09laia.000webhostapp.com/deleteproduct.php";
    try {
      var responseDelete =
          await http.post(
            Uri.parse(urlDeleteProduct), 
            body: {"id": id}
            );
          var deleteDataProduct = jsonDecode(responseDelete.body);
          if (deleteDataProduct["success"]=="true") {
            print("Product deleted successfully");
            setState(() {
              productList.removeWhere((products) => products['id']== id);

            });
          }else{
            print("product deleted failed");
          }
    } catch (exc) {
      print(exc);
    }
  }
  List filteredProductList = [];
  void editProduct(Map product) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProduct(products: product)),
    ).then((updated) {
      if (updated != null && updated) {
        getAllProduct(); 
      }
    });
  }

  @override
  void initState() {
    getAllProduct();
    super.initState();
  }

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
            ),
            ),
        title: const Text(
          "Product List",
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
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, int index) {
          return Card(
            margin: EdgeInsets.all(5),
            child: ListTile(
              leading: ClipOval(
                child: Image.network(
                  '${productList[index]['images']}',
                  fit: BoxFit.fill,
                ),
              ),
              title: Text(
                productList[index]['name'],
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      productList[index]['description'],
                      style: const TextStyle(
                          fontSize: 9,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Rp ${productList[index]['price']}', 
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.green,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                         editProduct(filteredProductList[index]);
                      },
                      icon: const Icon(
                        CupertinoIcons.upload_circle_fill,
                        size: 18,
                        color: Colors.amber,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () {
                        
                        deleteProduct(productList[index]["id"]);
                        getAllProduct();
                      },
                      icon: const Icon(
                        CupertinoIcons.delete_solid,
                        size: 18,
                        color: Colors.red,
                      )),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddProduct()));
        },
        mini: true,
        splashColor: Colors.green.shade500,
        backgroundColor: Colors.green,
        child: const Icon(
          CupertinoIcons.add_circled_solid,
          size: 12,
          color: Colors.white,
        ),
      ),
    );
  }
}
