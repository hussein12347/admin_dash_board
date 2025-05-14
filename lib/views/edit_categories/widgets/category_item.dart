import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constant/constant.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.image,
    required this.title,
    required this.deleteOnTap,
    required this.editOnTap,
  });

  final String image;
  final String title;
  final VoidCallback editOnTap;
  final VoidCallback deleteOnTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 300;

          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      IconButton(
                        icon: const Icon(Icons.edit, size: 20, color: Colors.blue),
                        onPressed: () async {
                          editOnTap();
                          // // منطق التعديل هنا
                          // await context.read<EditProductCubit>().getCategoryDetails();
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => EditProductView(productModel: widget.product,),));
                        },
                      ),
                      IconButton(
                        icon: Icon(CupertinoIcons.delete, size: 20, color: Colors.red),
                        onPressed: () async{
                          deleteOnTap();
                          // await context.read<EditProductCubit>().deleteProduct( product: widget.product);
                        },
                      )

                    ],
                  ),
                  Container(
                    height: isWide ? 80 : 64,
                    width: isWide ? 80 : 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xffF3F5F7),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                        width: isWide ? 76 : 60,
                        height: isWide ? 76 : 60,
                        errorBuilder:
                            (context, error, stackTrace) => const Icon(
                              Icons.broken_image,
                              size: 32,
                              color: Colors.grey,
                            ),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: kFontSize13,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
