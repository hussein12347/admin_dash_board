import 'package:admin_dash_board/core/logic/admin_logic/edit_categories/edit_category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/edit_categories_body.dart';

class EditCategoriesView extends StatelessWidget {
  const EditCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(title: Text("تعديل الفئات"),centerTitle: true,),

      body:BlocProvider<EditCategoryCubit>(

          create: (context) =>EditCategoryCubit()..getCategoryDetails() ,

          child: EditCategoriesBody()) ,

    );
  }
}
