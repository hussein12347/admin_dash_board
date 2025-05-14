import 'dart:typed_data';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant/constant.dart';
import '../../../core/logic/admin_logic/edit_product/edit_product_cubit.dart';
import '../../../core/models/category_model.dart';
import '../../../core/models/product_model.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/item_widget.dart';
import '../../../core/widgets/pick_image.dart';
import '../../../core/widgets/showMessage.dart';

class EditProductView extends StatefulWidget {
  const EditProductView({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<EditProductView> createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {
  final GlobalKey<FormState> key = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  final nameController = TextEditingController();
  final newPriceController = TextEditingController();
  final oldPriceController = TextEditingController();
  final descriptionController = TextEditingController();
  final availableQuantityController = TextEditingController();

  late ProductModel currentProduct ;
  List<CategoryModel> _categories = [];
  CategoryModel selectCategoryModel=CategoryModel(id: '', createdAt: DateTime.now(), name: 'اختر القسم', imageUrl: '');

  @override
  void initState() {
    super.initState();
    currentProduct = widget.productModel;

    _categories = context
        .read<EditProductCubit>()
        .categoriesModelList;
    selectCategoryModel = _categories.firstWhere(
          (element) => element.id == widget.productModel.category_id,
      orElse: () => CategoryModel(id: '', createdAt: DateTime.now(), name: 'اختر القسم', imageUrl: ''),  // إرجاع قيمة افتراضية إذا لم يتم العثور على العنصر
    );



    nameController.text=widget.productModel.productName;
    newPriceController.text=widget.productModel.price;
    oldPriceController.text=widget.productModel.oldPrice??'0';
    descriptionController.text=widget.productModel.description;
    availableQuantityController.text=widget.productModel.available_quantity;

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
    return BlocConsumer<EditProductCubit, EditProductState>(
      listener: (context, state) {
        if (state is EditProductsSuccess ) {
          ShowMessage.showToast(
            "تم تحديث المنتج بنجاح",
            backgroundColor: kPrimaryColor,
          );
          Navigator.pop(context);
        } else if (state is EditProductsError) {
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

              if (state is EditProductsLoading || state is UploadImageLoading ||
                  state is GetCategoryDetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is GetCategoryDetailsSuccess || state is UploadImageSuccess) {

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
                          if (selectCategoryModel.id.isEmpty) {
                            ShowMessage.showToast("يرجى اختيار القسم");
                            return;
                          }

                          if (key.currentState!.validate()) {
                            if (bytes != null) {
                              // حالة اختيار صورة جديدة
                              if (state is UploadImageSuccess) {
                                currentProduct = currentProduct.copyWith(
                                  imageUrl: context.read<EditProductCubit>().path,
                                  delete_image_url: context.read<EditProductCubit>().delete_path,
                                );
                                await context.read<EditProductCubit>().EditProduct(
                                  product: currentProduct,
                                );
                              } else {
                                await context.read<EditProductCubit>().uploadImage(
                                  image: bytes!,
                                  imageName: DateTime.now().toIso8601String().replaceAll(':', '-').replaceAll('.', '-') + imageName!,
                                  bucketName: 'images', delete_image_url: currentProduct.delete_image_url??"",
                                );
                              }
                            } else if (currentProduct.imageUrl != null &&
                                currentProduct.imageUrl!.isNotEmpty) {
                              // حالة عدم تغيير الصورة (استخدام الصورة القديمة)
                              await context.read<EditProductCubit>().EditProduct(
                                product: currentProduct,
                              );
                            } else {
                              ShowMessage.showToast("يرجى اختيار الصورة");
                            }
                          } else {
                            setState(() {
                              autovalidateMode = AutovalidateMode.always;
                            });
                          }
                        },
                        text: (state is UploadImageSuccess && bytes != null)
                            ? "تحديث المنتج"
                            : bytes == null
                            ? "تحديث المنتج"
                            : "أرفع الصورة",
                      ),
                    ],
                  ),
                ),
              );
              }
              return SizedBox();
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
                    value.id ,
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
