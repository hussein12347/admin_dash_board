import 'package:admin_dash_board/core/logic/admin_logic/add_products/add_products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/add_products_body.dart';

class AppProductView extends StatelessWidget {
  const AppProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductsCubit()..getCategoryDetails(),
      child: Scaffold(
        appBar: AppBar( centerTitle: true,title: Text("اضافة منتجات"),),
        body:AddProductsBody() ,
      ),
    );
  }
}
