import 'package:admin_dash_board/core/logic/admin_logic/add_categories/add_categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/ad_category_body.dart';

class AdCategoryView extends StatelessWidget {
  const AdCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddCategoriesCubit>(
      create: (context) => AddCategoriesCubit(),
      child: Scaffold(
        appBar: AppBar(title: Text("اضافة فئة"),
        centerTitle: true,),
        body: AdCategoryBody(),
      ),
    );
  }
}
