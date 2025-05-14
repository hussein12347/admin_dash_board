import 'package:flutter/material.dart';

import '../widgets/edit_products_body.dart';

class EditProductsViews extends StatelessWidget {
  const EditProductsViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تعديل المنتجات"), centerTitle: true),
       body:EditProductsBody() ,
    );
  }
}
