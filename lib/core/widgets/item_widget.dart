import 'package:admin_dash_board/core/logic/admin_logic/edit_product/edit_product_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../views/edit_product/widgets/edit_product_view.dart';
import '../constant/constant.dart';
import '../models/product_model.dart';

class ItemWidget extends StatefulWidget {
  final ProductModel product;
  final bool isEditing;

  const ItemWidget({super.key, required this.product, this.isEditing = false});

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double newPrice = double.tryParse(widget.product.price) ?? 0;
    final double oldPrice = double.tryParse(widget.product.oldPrice ?? '') ?? 0;
    final int discountPercentage = kCalculateDiscountPercentage(
      oldPrice: oldPrice,
      newPrice: newPrice,
    );
    final double availableQty =
        double.tryParse(widget.product.available_quantity) ?? 0;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Favorite Icon

              // Product Content
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    Center(
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.network(
                          widget.product.imageUrl ?? '',
                          fit: BoxFit.contain,
                          errorBuilder:
                              (_, __, ___) =>
                                  const Icon(Icons.image_not_supported),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Product Info
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      title: Text(
                        widget.product.productName,
                        style: TextStyle(fontSize: kFontSize16),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$newPrice جنية',
                            style: TextStyle(
                              color: kSecondaryColor,
                              fontSize: kFontSize13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (discountPercentage > 0)
                            Text(
                              '$oldPrice جنية',
                              style: TextStyle(
                                fontSize: kFontSize13,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                      trailing:
                          availableQty <= 0
                              ? Tooltip(
                                message: 'غير متوفر في المخزون',
                                child: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                              : Tooltip(
                                message: 'متوفر في المخزون',
                                child: CircleAvatar(
                                  backgroundColor: kPrimaryColor,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                    ),
                  ],
                ),
              ),

              // Discount Badge
              if (discountPercentage > 0)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'خصم ${discountPercentage.toInt()}%',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: kFontSize12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              if (widget.isEditing)
                Positioned(
                  top: 4,
                  right: 4,
                  child: IconButton(
                    icon: const Icon(Icons.edit, size: 20, color: Colors.blue),
                    onPressed: () async {
                      // منطق التعديل هنا
                      await context.read<EditProductCubit>().getCategoryDetails();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditProductView(productModel: widget.product,),));
                    },
                  ),
                ),
              if (widget.isEditing)
                Positioned(
                top: 4,
                left: 4,
                child: IconButton(
                  icon: Icon(CupertinoIcons.delete, size: 20, color: Colors.red),
                  onPressed: () async{
                    await context.read<EditProductCubit>().deleteProduct( product: widget.product);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
