// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:food_now/model/products.dart';
// import 'package:food_now/model/utilities.dart';

// import '../../homepage/components/fragment/favorite_fragment.dart';

// class Body extends StatefulWidget {
//   List<Products> dataProduct = <Products>[];

//   @override
//   State<Body> createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   List<String> _tags = [];
//   List<Products> products = Utilities().getProducts() as List<Products>;
//   List<Products> productsResult = <Products>[];
//   late TextEditingController textEditingController;

//   @override
//   void initState() {
//     super.initState();
//     _tags.addAll(['food', 'categories', 'bread']);
//     textEditingController = new TextEditingController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: _scaffoldKey,
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           title: buildRow(),
//         ),
//         body: buildContainer(context));
//   }

//   Widget buildTag(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       color: Colors.white,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Recommend'),
//           SizedBox(
//             height: 10,
//           ),
//           Tags(
//             itemCount: _tags.length,
//             itemBuilder: (index) {
//               return ItemTags(
//                 index: index,
//                 title: _tags[index],
//                 onPressed: (item) {
//                   setState(() {
//                     widget.dataProduct.clear();

//                     widget.dataProduct.addAll(Utilities().find(item.title));
//                   });
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildRow() {
//     return Row(
//       children: [
//         Expanded(
//           child: TextField(
//             controller: textEditingController,
//             decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.white,
//                 hintText: "Search product",
//                 prefixIcon: Icon(Icons.search)),
//             onChanged: (value) {
//               setState(() {
//                 if (value.isEmpty) {
//                   widget.dataProduct = new List<Products>();
//                   return;
//                 }
//                 widget.dataProduct.clear();
//                 widget.dataProduct.addAll(Utilities().find(value));
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildContainer(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height,
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           buildTag(context),
//           if (widget.dataProduct.length == 0)
//             Expanded(child: Center(child: Text('No item')))
//           else
//             Expanded(
//                 child: ListView.builder(
//                     itemCount: widget.dataProduct.length,
//                     itemBuilder: (context, index) {
//                       return ProductItemList(
//                         product: widget.dataProduct[index],
//                       );
//                     }))
//         ],
//       ),
//     );
//   }
// }
