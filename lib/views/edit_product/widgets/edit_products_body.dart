import 'package:admin_dash_board/core/logic/admin_logic/edit_product/edit_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/products_grid_view.dart';

class EditProductsBody extends StatefulWidget {
  const EditProductsBody({super.key});

  @override
  State<EditProductsBody> createState() => _EditProductsBodyState();
}

class _EditProductsBodyState extends State<EditProductsBody> {
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
              ProductGridView(
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





