import 'package:flutter/material.dart';
import 'package:flutter_sqflite_example/data/dbHelper.dart';
import 'package:flutter_sqflite_example/models/product.dart';

class ProductAdd extends StatefulWidget {
  @override
  //_ProductAddState createState() => _ProductAddState();
  State<StatefulWidget> createState() {
    return _ProductAddState();
  }
}

class _ProductAddState extends State<ProductAdd> {
  var dbHelper = DbHelper();
  TextEditingController txtName = new TextEditingController();
  TextEditingController txtDescription = new TextEditingController();
  TextEditingController txtUnitPrice = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni ürün ekle"),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            buildNameField(),
            buildDescriptionField(),
            buildUnitPriceField(),
            buildSaveButton()
          ],
        ),
      ),
    );
  }

  buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün adı: "),
      controller: txtName,
    );
  }

  buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün açıklaması: "),
      controller: txtDescription,
    );
  }

  buildUnitPriceField() {
    return TextField(
      decoration: InputDecoration(labelText: "Birim fiyat: "),
      controller: txtUnitPrice,
    );
  }

  buildSaveButton() {
    // ignore: deprecated_member_use
    return FlatButton(
      child: Text("Ekle"),
      color: Colors.blue,
      onPressed: () {
        addProduct();
      },
    );
  }

  void addProduct() async {
    var result = await dbHelper.insertProduct(Product(
        name: txtName.text,
        description: txtDescription.text,
        unitPrice: double.tryParse(txtUnitPrice.text)));
    Navigator.pop(context, true);
  }
}
