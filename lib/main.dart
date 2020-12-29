import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appseccccccccccccccccc/auth_screen.dart';

import 'package:provider/provider.dart';

import 'add_new_user.dart';
import 'add_products.dart';
import 'auth_provider.dart';
import 'product_details.dart';
import 'products.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<AuthProvider>(
          create: (_)=>AuthProvider()
      ),
      ChangeNotifierProvider<Products>(
        create: (_) => Products(),
      ),
      ChangeNotifierProvider<AddNewUser>(
        create: (_) => AddNewUser(),
      ),

    ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.orange,
          canvasColor: Color.fromRGBO(255, 238, 219, 1)),
      debugShowCheckedModeBanner: false,
      home: AuthScreen(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return null;
    // List<Product> prodList =
    //     Provider.of<Products>(context, listen: true).productsList;
    //
    // Widget detailCard(id, tile, desc, price, imageUrl, ctx) {
       return null;
      //   FlatButton(
    //     onPressed: () {
    //       Navigator.push(
    //         ctx,
    //         MaterialPageRoute(builder: (_) => ProductDetails(id)),
    //       ).then((id) =>
    //           Provider.of<Products>(context, listen: false).delete(id));
    //     },
    //     child: Column(
    //       children: [
    //         SizedBox(height: 5),
    //         Card(
    //           elevation: 10,
    //           color: Color.fromRGBO(115, 138, 119, 1),
    //           child: Row(
    //             children: <Widget>[
    //               Expanded(
    //                 flex: 3,
    //                 child: Container(
    //                   padding: EdgeInsets.only(right: 10),
    //                   width: 130,
    //                   child: Hero(
    //                     tag: id,
    //                     child: Image.network(imageUrl, fit: BoxFit.fill),
    //                   ),
    //                 ),
    //               ),
    //               Expanded(
    //                 flex: 3,
    //                 child: Column(
    //                   //mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: <Widget>[
    //                     SizedBox(height: 10),
    //                     Text(
    //                       tile,
    //                       style: TextStyle(
    //                           color: Colors.white,
    //                           fontSize: 20,
    //                           fontWeight: FontWeight.bold),
    //                     ),
    //                     Divider(color: Colors.white),
    //                     Container(
    //                       width: 200,
    //                       child: Text(
    //                         desc,
    //                         style: TextStyle(color: Colors.white, fontSize: 14),
    //                         softWrap: true,
    //                         overflow: TextOverflow.fade,
    //                         textAlign: TextAlign.justify,
    //                         maxLines: 3,
    //                       ),
    //                     ),
    //                     Divider(color: Colors.white),
    //                     Text(
    //                       "\$$price",
    //                       style: TextStyle(color: Colors.black, fontSize: 18),
    //                     ),
    //                     SizedBox(height: 13),
    //                   ],
    //                 ),
    //               ),
    //               Expanded(flex: 1, child: Icon(Icons.arrow_forward_ios)),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }
    //
    // return Scaffold(
    //   appBar: AppBar(title: Text('My Products')),
    //   body:
    //   prodList.isEmpty
    //       ? Center(
    //           child: Text('No Products Added.', style: TextStyle(fontSize: 22)))
    //       : ListView(
    //           children: prodList
    //               .map(
    //                 (item) => Builder(
    //                     builder: (ctx) => detailCard(item.id, item.title,
    //                         item.description, item.price, item.imageUrl, ctx)),
    //               )
    //               .toList(),
    //         ),
    //   floatingActionButton: Container(
    //     width: 180,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(20.0),
    //       color: Theme.of(context).primaryColor,
    //     ),
    //     child: FlatButton.icon(
    //       label: Text("Add Product",
    //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
    //       icon: Icon(Icons.add),
    //       onPressed: () => Navigator.push(
    //           context, MaterialPageRoute(builder: (_) => AddProduct())),
    //     ),
    //   ),
    //);
  }
}

// import 'package:flutter/material.dart';
// import 'package:encrypt/encrypt.dart' as encrypt;
//
// import 'my_encryption.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   TextEditingController tec = TextEditingController();
//   var encryptedText, plainText;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Encryption/Decryption"),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: TextField(
//                 controller: tec,
//               ),
//             ),
//             Column(
//               children: [
//                 Text(
//                   "PLAIN TEXT",
//                   style: TextStyle(
//                     fontSize: 25,
//                     color: Colors.blue[400],
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(plainText == null ? "" : plainText),
//                 ),
//               ],
//             ),
//             Column(
//               children: [
//                 Text(
//                   "ENCRYPTED TEXT",
//                   style: TextStyle(
//                     fontSize: 25,
//                     color: Colors.blue[400],
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                       encryptedText == null
//                       ? ""
//                       : encryptedText is encrypt.Encrypted
//                       ? encryptedText.base64
//                       : encryptedText
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 RaisedButton(
//                   onPressed: () {
//                     plainText = tec.text;
//                     setState(() {
//                       encryptedText =
//                           MyEncryptionDecryption.encryptSalsa20(plainText);
//                     });
//                     tec.clear();
//                   },
//                   child: Text("Encrypt"),
//                 ),
//                 SizedBox(width: 15,),
//                 RaisedButton(
//                   onPressed: () {
//                     setState(() {
//                       encryptedText =
//                           MyEncryptionDecryption.decryptSalsa20(encryptedText);
//                       print("Type: " + encryptedText.runtimeType.toString());
//                     });
//                   },
//                   child: Text("Decrypt"),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }