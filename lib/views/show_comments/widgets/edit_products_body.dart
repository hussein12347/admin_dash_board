import 'package:admin_dash_board/core/logic/admin_logic/edit_product/edit_product_cubit.dart';
import 'package:admin_dash_board/views/show_comments/widgets/show_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ShowCommentsBody extends StatefulWidget {
  const ShowCommentsBody({super.key});

  @override
  State<ShowCommentsBody> createState() => _ShowCommentsBodyState();
}

class _ShowCommentsBodyState extends State<ShowCommentsBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<EditProductCubit>().getStandardProductData();

  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProductCubit, EditProductState>(
      builder: (context, state) {
        if (state is GetProductDataLoading || state is DeleteProductDataLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {

          return CustomScrollView(
            slivers: [
              ShowProducts(
                isEditing: false,
                isInHome: false,
                products: context.watch<EditProductCubit>().standardProductModelList,
              ),
            ],
          );
        }
      },
    );
  }
}





