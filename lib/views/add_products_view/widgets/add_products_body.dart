import 'dart:typed_data';

import 'package:admin_dash_board/core/constant/constant.dart';
import 'package:admin_dash_board/core/logic/admin_logic/add_products/add_products_cubit.dart';
import 'package:admin_dash_board/core/models/product_model.dart';
import 'package:admin_dash_board/core/widgets/custom_button.dart';
import 'package:admin_dash_board/core/widgets/custom_text_field.dart';
import 'package:admin_dash_board/core/widgets/item_widget.dart';
import 'package:admin_dash_board/core/widgets/showMessage.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/category_model.dart';
import '../../../core/widgets/pick_image.dart';

class AddProductsBody extends StatefulWidget {
  const AddProductsBody({super.key});

  @override
  State<AddProductsBody> createState() => _AddProductsBodyState();
}

class _AddProductsBodyState extends State<AddProductsBody> {
  final GlobalKey<FormState> key = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  final nameController = TextEditingController();
  final newPriceController = TextEditingController();
  final oldPriceController = TextEditingController();
  final descriptionController = TextEditingController();
  final availableQuantityController = TextEditingController();

  ProductModel currentProduct = ProductModel(
    productName: '',
    price: '0',
    oldPrice: '0',
    available_quantity: '0',
    description: '',
    category_id: '',
    boughtTimes: 0,
    productId: '',
    createdAt: DateTime.now(),
    imageUrl: '',
    delete_image_url: '',
  );
  List<CategoryModel> _categories = [];
   CategoryModel selectCategoryModel=CategoryModel(id: '', createdAt: DateTime.now(), name: 'اختر القسم', imageUrl: '');

  @override
  void initState() {
    super.initState();
    _categories = context
        .read<AddProductsCubit>()
        .categoriesModelList;
    if (_categories.isNotEmpty) {
      selectCategoryModel = _categories[0];
    }
    nameController.addListener(_updateProduct);
    newPriceController.addListener(_updateProduct);
    oldPriceController.addListener(_updateProduct);
    descriptionController.addListener(_updateProduct);
    availableQuantityController.addListener(_updateProduct);
  }

  void _updateProduct() {
    setState(() {
      currentProduct = currentProduct.copyWith(
        productName: nameController.text,
        price: newPriceController.text,
        oldPrice: oldPriceController.text,
        description: descriptionController.text,
        available_quantity: availableQuantityController.text,
      );
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    newPriceController.dispose();
    oldPriceController.dispose();
    descriptionController.dispose();
    availableQuantityController.dispose();
    super.dispose();
  }

  Uint8List? bytes;
  String? imageName;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddProductsCubit, AddProductsState>(
      listener: (context, state) {
        if (state is AddProductsSuccess) {
          ShowMessage.showToast(
            "تم إضافة المنتج بنجاح",
            backgroundColor: kPrimaryColor,
          );
          Navigator.pop(context);
        } else if (state is AddProductsError) {
          ShowMessage.showToast(
            "لم يتم اضافة العنصر تحقق من المدخلات أو حاول لاحقا",
          );
        }
      },
      builder:
          (context, state) =>
          LayoutBuilder(
            builder: (context, constraints) {
              bool isWide = constraints.maxWidth > 800;

              if (state is AddProductsLoading || state is UploadImageLoading ||
                  state is GetCategoryDetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: key,
                  autovalidateMode: autovalidateMode,
                  child: Column(
                    children: [
                      isWide
                          ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: _buildFormFields()),
                          const SizedBox(width: 24),
                          _buildProductPreview(),
                        ],
                      )
                          : Column(
                        children: [
                          _buildFormFields(),
                          const SizedBox(height: 24),
                          _buildProductPreview(),
                        ],
                      ),
                      const SizedBox(height: 40),
                      CustomButton(
                        onPressed: () async {
                          if (bytes == null) {
                            ShowMessage.showToast("يرجى اختيار الصورة");
                          }
                          if(selectCategoryModel.id.isEmpty){
                            ShowMessage.showToast("يرجى اختيار القسم");
                            return;
                          }
                          if (key.currentState!.validate() &&
                              currentProduct.imageUrl!.isNotEmpty &&
                              bytes != null) {
                            if (state is UploadImageSuccess) {
                              currentProduct = currentProduct.copyWith(
                                imageUrl: state.path,
                                delete_image_url: state.Deletepath,
                              );
                              await context.read<AddProductsCubit>().addProduct(
                                product: currentProduct,
                              );
                            } else {
                              await context
                                  .read<AddProductsCubit>()
                                  .uploadImage(
                                image: bytes!,
                                imageName: DateTime.now().toIso8601String().replaceAll(':', '-').replaceAll('.', '-') + imageName!,
                                bucketName: 'images',
                              );
                            }
                          } else {
                            setState(() {
                              autovalidateMode = AutovalidateMode.always;
                            });
                          }
                        },

                        text:
                        (state is UploadImageSuccess)
                            ? "إضافة المنتج"
                            : "أرفع الصورة",
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }

  Widget _buildFormFields() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextFormField(
              hintText: "الإسم",
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "يرجى إدخال اسم المنتج";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              hintText: "السعر الجديد",
              controller: newPriceController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "يرجى إدخال السعر الجديد";
                }
                if (double.tryParse(value) == null) {
                  return "يرجى إدخال رقم صالح";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              hintText: "السعر القديم",
              controller: oldPriceController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "يرجى إدخال السعر القديم";
                }
                if (double.tryParse(value) == null) {
                  return "يرجى إدخال رقم صالح";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              hintText: "الوصف",
              controller: descriptionController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "يرجى إدخال وصف المنتج";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              hintText: "الكمية المتاحة",
              controller: availableQuantityController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "يرجى إدخال الكمية المتاحة";
                }
                if (int.tryParse(value) == null) return "يرجى إدخال عدد صحيح";
                return null;
              },
            ),
            const SizedBox(height: 16),
             CustomDropdown<CategoryModel>.searchRequest(
              searchHintText: "ابحث عن القسم",
              // Optional search box hint
              noResultFoundText: "لا يوجد قسم بهذا الاسم",
              hintText: 'اختر القسم',
              items: _categories,
              initialItem: _categories.isNotEmpty ? selectCategoryModel : null,
              onChanged: (value) {
                setState(() {
                  selectCategoryModel =value!;
                  currentProduct = currentProduct.copyWith(
                    category_id:
                    value.id,
                  );
                });
              },
              futureRequest: (String query) async {
                return Future.delayed(const Duration(milliseconds: 300), () {
                  return _categories
                      .where(
                        (category) =>
                        category.name.toLowerCase().contains(
                          query.toLowerCase(),
                        ),
                  )
                      .toList();
                });
              },
              headerBuilder:
                  (context, selectedItem, enabled) =>
                  Text(
                    selectedItem.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              listItemBuilder:
                  (context, item, isSelected, onItemSelect) =>
                  ListTile(
                    title: Text(item.name),
                    leading: CircleAvatar(
                      child: Text(
                        (_categories.indexWhere((element) => element == item) +
                            1)
                            .toString(),
                      ),
                    ),
                    onTap: onItemSelect,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductPreview() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 250),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GestureDetector(
            onTap: () async {
              final image = await pickImage();

              setState(() {
                bytes = image!.files.first.bytes;
                imageName = image.files.first.name;
                currentProduct = currentProduct.copyWith(
                  imageUrl: image.files.single.path!,
                );
              });
            },
            child: ItemWidget(product: currentProduct),
          ),
        ),
      ),
    );
  }
}
