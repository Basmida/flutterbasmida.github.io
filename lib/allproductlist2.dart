import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class SemuaProduk extends StatefulWidget {
  const SemuaProduk({super.key});

  @override
  State<SemuaProduk> createState() => _SemuaProdukState();
}

class _SemuaProdukState extends State<SemuaProduk> {
  List listProduk = [];
  Future<void> getSemuaProduk() async {
    String UrlProduk =
        "https://basmida09laia.000webhostapp.com/allproductlist.php";

    try {
      var response = await http.get(Uri.parse(UrlProduk));
      listProduk = jsonDecode(response.body);
      setState(() {
        listProduk = jsonDecode(response.body);
      });
    } catch (exc) {
      print(exc);
    }
  }

  @override
  void initState() {
    getSemuaProduk();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(
          "Boutique",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        actions: [
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.notifications,
            color: Colors.white,
          )
        ],
      ),
      body: ListView.builder(
        itemCount: listProduk.length,
        itemBuilder: (context, int index) {
          return Card(
            margin: EdgeInsets.all(5),
            child: ListTile(
              leading: ClipOval(
                child: Image.network(
                  '${listProduk[index]['images']}',
                  fit: BoxFit.fill,
                ),
              ),
              title: Text(
                listProduk[index]['name'],
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      listProduk[index]['description'],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      listProduk[index]['price'],
                    ),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.upload_circle,
                      color: Colors.yellow,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: CircleBorder(),
        splashColor: Colors.pink[600],
        backgroundColor: Colors.pink[400],
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
      ),
    );
  }
}
