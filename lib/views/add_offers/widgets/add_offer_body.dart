import 'dart:developer';
import 'dart:typed_data';
import 'package:admin_dash_board/core/constant/constant.dart';
import 'package:admin_dash_board/core/logic/admin_logic/add_offers/add_offer_cubit.dart';

import 'package:admin_dash_board/core/widgets/showMessage.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/product_model.dart';

class AddOfferBody extends StatefulWidget {
  const AddOfferBody({super.key});

  @override
  State<AddOfferBody> createState() => _AddOfferBodyState();
}

class _AddOfferBodyState extends State<AddOfferBody> {
  Uint8List? imageBytes;
  String? imageName;
  String offerTitle = '';

  List<ProductModel> _allProducts = [];
  List<ProductModel> _selectedProducts = [];

  @override
  void initState() {
    super.initState();
    _allProducts = context.read<AddOfferCubit>().standardProductModelList;
  }

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.single.bytes != null) {
      setState(() {
        imageBytes = result.files.single.bytes;
        imageName = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddOfferCubit, AddOfferState>(
      listener: (context, state) {},
      builder: (context, state) {
        Future<void> onSave() async {
          if (offerTitle.trim().isEmpty) {
            ShowMessage.showToast("يرجى إدخال اسم العرض");
            return;
          }

          if (_selectedProducts.isEmpty) {
            ShowMessage.showToast("يرجى اختيار المنتجات");
            return;
          }

          if (imageBytes == null) {
            ShowMessage.showToast("يرجى اختيار صورة");
            return;
          }

          if (state is UploadImageSuccess) {
            log(_selectedProducts.toString());
            await context.read<AddOfferCubit>().addOffer(
              imageUrl: state.path,
              products: _selectedProducts,
              offerName: offerTitle, delete_image_url: state.delete_path,
            );

            ShowMessage.showToast("تم حفظ لوحة الاعلانات", backgroundColor: kPrimaryColor);
            Navigator.pop(context);
          } else {
            await context.read<AddOfferCubit>().uploadImage(
              image: imageBytes!,
              imageName: DateTime.now().toIso8601String().replaceAll(':', '-').replaceAll('.', '-') + imageName!,
              bucketName: 'offers',
            );
          }
        }

        if (state is AddOfferLoading || state is UploadImageLoading || state is GetProductDataLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 800;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // عنوان
                      const Text(
                        'إضافة عرض جديد',
                        style: TextStyle(fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 24),

                      // اسم العرض
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'اسم العرض',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) =>
                            setState(() => offerTitle = value),
                      ),
                      const SizedBox(height: 24),

                      // صورة العرض
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: pickImage,
                          child: Container(
                            width: isWide ? 350 : 250,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                              image: imageBytes != null
                                  ? DecorationImage(
                                image: MemoryImage(imageBytes!),
                                fit: BoxFit.cover,
                              )
                                  : null,
                            ),
                            child: imageBytes == null
                                ? const Center(
                              child: Icon(Icons.add_a_photo, size: 30,
                                  color: Colors.black54),
                            )
                                : null,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // اختيار المنتجات
                      CustomDropdown<ProductModel>.multiSelectSearchRequest(
                        hintText: 'اختر المنتجات',
                        searchHintText: "ابحث عن المنتجات",
                        noResultFoundText: "لا يوجد منتج بهذا الاسم",
                        items: _allProducts,
                        initialItems: _selectedProducts.isNotEmpty
                            ? _selectedProducts
                            : null,
                        onListChanged: (selected) {
                          setState(() {
                            _selectedProducts = selected;
                          });
                        },
                        futureRequest: (query) async {
                          await Future.delayed(
                              const Duration(milliseconds: 300));
                          return _allProducts.where((product) =>
                              product.productName.toLowerCase().contains(
                                  query.toLowerCase())).toList();
                        },
                        headerListBuilder: (context, selectedItems, enabled) {
                          return Text(
                            selectedItems.first.productName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          );
                        },
                        listItemBuilder: (context, item, isSelected,
                            onItemSelect) {
                          final index = _allProducts.indexWhere((
                              element) => element == item) + 1;
                          return ListTile(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey, width: 1), // الحدود
                              borderRadius: BorderRadius.circular(12),        // الزوايا
                            ),
                            tileColor:isSelected?kLight2PrimaryColor:null ,
                            title: Text(item.productName),
                            subtitle: Text("السعر ${item.price} جنية") ,
                            leading: CircleAvatar(
                              child: Text(index.toString()),
                            ),
                            onTap: onItemSelect,
                          );
                        },
                      ),

                      const SizedBox(height: 24),

                      // المنتجات المختارة
                      if (_selectedProducts.isNotEmpty) ...[
                        const Text(
                          'المنتجات المختارة:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _selectedProducts.map((product) {
                            return Chip(
                              label: Text(product.productName),
                              avatar: const Icon(
                                  Icons.check_circle, color: Colors.green),
                            );
                          }).toList(),
                        ),
                      ],

                      const SizedBox(height: 32),

                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton.icon(
                          onPressed: onSave,
                          icon: const Icon(Icons.save),
                          label: Text(state is UploadImageSuccess
                              ? "حفظ العرض"
                              : "أرفع الصورة"),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}


