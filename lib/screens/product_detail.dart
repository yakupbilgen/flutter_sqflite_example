import 'package:flutter/material.dart';
import 'package:flutter_sqflite_example/data/dbHelper.dart';
import 'package:flutter_sqflite_example/models/product.dart';

class ProductDetail extends StatefulWidget {
  Product product;
  ProductDetail(this.product);
  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState(product);
  }
}

enum Options { delete, update }

class _ProductDetailState extends State {
  Product product;
  _ProductDetailState(this.product);
  DbHelper dbHelper = DbHelper();
  TextEditingController txtName = new TextEditingController();
  TextEditingController txtDescription = new TextEditingController();
  TextEditingController txtUnitPrice = new TextEditingController();

  @override
  void initState() {
    txtName.text = product.name;
    txtDescription.text = product.description;
    txtUnitPrice.text = product.unitPrice.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün detayı: ${product.name}"),
        actions: <Widget>[
          PopupMenuButton<Options>(
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
              PopupMenuItem<Options>(
                value: Options.delete,
                child: Text("Sil"),
              ),
              PopupMenuItem<Options>(
                  value: Options.update, child: Text("Güncelle")),
            ],
            onSelected: selectProcess,
          )
        ],
      ),
      body: buildProductDetail(),
    );
  }

  buildProductDetail() {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          buildNameField(),
          buildDescriptionField(),
          buildUnitPriceField(),
          Padding(padding: EdgeInsets.all(10)),
          buildButton()
        ],
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

  void selectProcess(Options options) async {
    switch (options) {
      case Options.delete:
        await dbHelper.deleteProduct(product.id);
        Navigator.pop(context, true);
        break;
      case Options.update:
        await dbHelper.updateProduct(Product.withId(
            id: product.id,
            name: txtName.text,
            description: txtDescription.text,
            unitPrice: double.tryParse(txtUnitPrice.text)));
        Navigator.pop(context, true);
        break;
      default:
    }
  }

  buildButton() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RaisedButton(
            padding: EdgeInsets.all(15),
            onPressed: () async {
              await dbHelper.deleteProduct(product.id);
              Navigator.pop(context, true);
            },
            child: const Text('Sil', style: TextStyle(fontSize: 20)),
          ),
          const SizedBox(height: 30),
          RaisedButton(
            padding: EdgeInsets.all(15),
            onPressed: () async {
              await dbHelper.updateProduct(Product.withId(
                  id: product.id,
                  name: txtName.text,
                  description: txtDescription.text,
                  unitPrice: double.tryParse(txtUnitPrice.text)));
              Navigator.pop(context, true);
            },
            child: const Text('Güncelle', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
