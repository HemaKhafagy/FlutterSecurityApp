import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'my_encryption.dart';

import 'products.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imageUrlCont = TextEditingController();
  TextEditingController tec = TextEditingController();
  var encryptedText, plainText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            TextField(
              decoration:
                  InputDecoration(labelText: "Title", hintText: "Add title"),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Description", hintText: "Add description"),
              controller: descController,
            ),
            TextField(
              decoration:
                  InputDecoration(labelText: "Price", hintText: "Add price"),
              controller: priceController,
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                  labelText: "Image Url",
                  hintText: "Paste your image url here"),
              controller: imageUrlCont,
            ),
            SizedBox(height: 30),
            Consumer<Products>(
              builder: (ctx, value, _) => RaisedButton(
                color: Colors.orangeAccent,
                textColor: Colors.black,
                child: Text("Add Product"),
                onPressed: () {
                  if (titleController.text.isEmpty ||
                      descController.text.isEmpty ||
                      priceController.text.isEmpty ||
                      imageUrlCont.text.isEmpty) {
                    Toast.show("Please enter all Fields", ctx,
                        duration: Toast.LENGTH_LONG);
                  } else {
                    try {
                      value.add(
                        id: DateTime.now().toString(),
                        title: titleController.text,
                        //title:MyEncryptionDecryption.encryptSalsa20(titleController.text),
                        description: descController.text,
                        price: double.parse(priceController.text),
                        imageUrl: imageUrlCont.text,
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
      Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: tec,
              ),
            ),
            // Column(
            //   children: [
            //     Text(
            //       "PLAIN TEXT",
            //       style: TextStyle(
            //         fontSize: 25,
            //         color: Colors.blue[400],
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Text(plainText == null ? "" : plainText),
            //     ),
            //   ],
            // ),
            Column(
              children: [
                Text(
                  "ENCRYPTED TEXT",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue[400],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Text(
                            encryptedText == null
                            ? ""
                            : encryptedText is encrypt.Encrypted
                            ? encryptedText.base64
                            : encryptedText
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () {
                    plainText = tec.text;
                    setState(() {
                      encryptedText =
                          MyEncryptionDecryption.encryptSalsa20(plainText);
                    });
                    tec.clear();
                  },
                  child: Text("Encrypt"),
                ),
                SizedBox(width: 15,),
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      encryptedText =
                          MyEncryptionDecryption.decryptSalsa20(encryptedText);
                      print("Type: " + encryptedText.runtimeType.toString());
                    });
                  },
                  child: Text("Decrypt"),
                )
              ],
            ),
          ],
        ),
      ),
          ],
        ),
      ),
    );
  }
}
