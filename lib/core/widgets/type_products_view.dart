import 'package:flutter/material.dart';

import '../models/product_model.dart';
import 'products_grid_view.dart';

class TypeProductsScreen extends StatelessWidget {
  const TypeProductsScreen({super.key, required this.title, required this.products, required this.onRefresh});
  final String title;
  final List<ProductModel> products;
  final RefreshCallback onRefresh;
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(

        appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,centerTitle: true,automaticallyImplyLeading: true,title: Text(title),),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            ProductGridView(isInHome: false, products: products,),
          ],
        ),
      ),),
    );
  }
}
