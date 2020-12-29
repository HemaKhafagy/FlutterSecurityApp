import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'my_encryption.dart';
import 'products.dart';

class ProductDetails extends StatefulWidget {
  final String id;

  ProductDetails(this.id);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  TextEditingController  titleController = TextEditingController();
  var descController = TextEditingController();
  var priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var encryptedText, plainText;
    List<Product> prodList = Provider.of<Products>(context, listen: true).productsList;

    var filteredItem = prodList.firstWhere((element) => element.id == widget.id, orElse: () => null);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.amber,
          title: filteredItem == null ? null : Text(filteredItem.title)),
      body: filteredItem == null
          ? null
          : ListView(
              children: [
                SizedBox(height: 10),
                buildContainer(filteredItem.imageUrl, filteredItem.id),
                SizedBox(height: 10),
                buildCard(filteredItem.title, filteredItem.description,
                    filteredItem.price),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                      onPressed: (){
                        final alert=AlertDialog(
                          content: Container(
                            height: 300,
                            child: Column(
                              children: [
                                TextField(
                                  decoration:InputDecoration(labelText: "Title", hintText: "Add title"),
                                  controller: titleController,
                                ),
                                SizedBox(height: 10,),
                                TextField(
                                  decoration: InputDecoration(
                                      labelText: "Description", hintText: "Add description"),
                                  controller: descController,
                                ),
                                SizedBox(height: 10,),
                                TextField(
                                  decoration:
                                  InputDecoration(labelText: "Price", hintText: "Add price"),
                                  controller: priceController,
                                ),
                                SizedBox(height: 40,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    FlatButton(
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Close',style: TextStyle(fontSize: 20),),
                                      color: Colors.amber,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    Consumer<Products>(
                                      builder: (ctx, value, _) => FlatButton(
                                        color: Colors.amber,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        textColor: Colors.black,
                                        child: Text("Update",style: TextStyle(fontSize: 20),),
                                        onPressed: () {
                                          if (titleController.text.isEmpty ||
                                              descController.text.isEmpty ||
                                              priceController.text.isEmpty
                                              ) {
                                            Toast.show("Please enter all Fields", ctx,
                                                duration: Toast.LENGTH_LONG);
                                          } else {
                                            try {
                                              var dec=titleController.text;
                                              value.update(
                                                filteredItem.id,
                                                 titleController.text,
                                                  //MyEncryptionDecryption.encryptSalsa20(dec),
                                                 descController.text,
                                                 double.parse(priceController.text),
                                                 filteredItem.imageUrl,
                                              );
                                              Navigator.pop(context);
                                            } catch (e) {
                                              Toast.show("Please enter a valid price", ctx,
                                                  duration: Toast.LENGTH_LONG);
                                              print(e);
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      showDialog(context: context,child: alert);
                      },
                      child: Text('Update',style: TextStyle(fontSize: 20),),
                    color: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 45),
                      child:
                      // Consumer<Products>(
                      //   builder: (ctx, value, _) =>
                            FlatButton(
                          color: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          textColor: Colors.black,
                          child: Text("Encrypt",style: TextStyle(fontSize: 20),),
                          onPressed: () {
                            setState(() {
                              MyEncryptionDecryption.encryptSalsa20(filteredItem.title);
                              MyEncryptionDecryption.encryptSalsa20(filteredItem.description);
                            });
                          },
                        ),
                      //),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 45),
                      child:
                      // Consumer<Products>(
                      //   builder: (ctx, value, _) =>
                            FlatButton(
                          color: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          textColor: Colors.black,
                          child: Text("Decrypt",style: TextStyle(fontSize: 20),),
                          onPressed: () {
                            setState(() {
                              MyEncryptionDecryption.decryptSalsa20(filteredItem.title);
                              MyEncryptionDecryption.decryptSalsa20(filteredItem.description);
                            });
                          },
                        ),
                      //),
                    ),
                  ],
                )
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.pop(context, filteredItem.id);
        },
        child: Icon(Icons.delete, color: Colors.black),
      ),
    );
  }

  Container buildContainer(String image, String id) {
    return Container(
      width: double.infinity,
      child: Center(
        child: Hero(
          tag: id,
          child: Image.network(image),
        ),
      ),
    );
  }

  Card buildCard(String title, String desc, double price) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(7),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(color: Colors.black),
            Text(desc,
                style: TextStyle(fontSize: 16), textAlign: TextAlign.justify),
            Divider(color: Colors.black),
            Text(
              "\$$price",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
