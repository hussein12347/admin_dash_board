import 'package:flutter/material.dart';

import '../widgets/edit_products_body.dart';

class ShowCommentsViews extends StatelessWidget {
  const ShowCommentsViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("عرض التعليقات"), centerTitle: true),
       body:ShowCommentsBody() ,
    );
  }
}
