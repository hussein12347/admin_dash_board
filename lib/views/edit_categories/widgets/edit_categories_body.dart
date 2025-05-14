import 'package:admin_dash_board/core/logic/admin_logic/edit_categories/edit_category_cubit.dart';
import 'package:admin_dash_board/core/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_item.dart';
import 'edit_view.dart'; // تأكد أنك مستورد هذا الملف

class EditCategoriesBody extends StatelessWidget {
  const EditCategoriesBody({super.key});

  // قائمة وهمية للتجربة


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCategoryCubit,EditCategoryState>(builder: (BuildContext context, state) {
      if(state is DeleteCategoryLoading ||state is  GetCategoryDetailsLoading ||state is UploadImageLoading){
        return Center(child: CircularProgressIndicator());
      }else {
        List<CategoryModel>categories=context.watch<EditCategoryCubit>().categoriesModelList;
        return Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200, // أقصى عرض لكل عنصر
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.85, // نسبة العرض إلى الارتفاع
            ),
            itemBuilder: (context, index) {
              final category = categories[index];
              return CategoryItem(
                title: category.name,
                image: category.imageUrl!, deleteOnTap: ()async {
                  await context.read<EditCategoryCubit>().deleteCategory(category: category);
              }, editOnTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (_) => EditCategoryCubit(),
                      child: EditCategoryPage(categoryModel: category),
                    ),
                  ),
                ).then((value) {
                  if (value == true) {
                    // قم بإعادة تحميل البيانات
                    context.read<EditCategoryCubit>().getCategoryDetails();
                  }
                });


              },

              );
            },
          ),
        );
      }
    },
    );
  }
}
