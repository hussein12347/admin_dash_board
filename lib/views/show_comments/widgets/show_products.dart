import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../core/models/product_model.dart';
import '../../../core/widgets/item_widget.dart';
import 'comments_view.dart';



class ShowProducts extends StatelessWidget {
  const ShowProducts({
    super.key,
    required this.isInHome,
    required this.products,  this.isEditing =true,
  });

  final bool isInHome;
  final bool isEditing;
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      sliver: SliverLayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.crossAxisExtent;
          final isLargeScreen = screenWidth > 1200;
          final isMediumScreen = screenWidth > 800 && screenWidth <= 1200;

          final crossAxisCount = isLargeScreen ? 6 : isMediumScreen ? 5 : 3;
          final childAspectRatio = isLargeScreen ? 1.2 : isMediumScreen ? 1.1 : 1.0;

          final itemCount = isInHome
              ? (products.length > 10 ? 10 : products.length)
              : products.length;

          return SliverGrid(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  columnCount: crossAxisCount,
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(

                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CommentsPage(product_id: products[index].productId,),));
                            },
                            child: ItemWidget(product: products[index],isEditing: isEditing,)),
                      ),
                    ),
                  ),
                );
              },
              childCount: itemCount,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: childAspectRatio,
            ),
          );
        },
      ),
    );
  }
}
