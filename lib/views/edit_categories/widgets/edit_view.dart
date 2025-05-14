import 'dart:typed_data';

import 'package:admin_dash_board/core/logic/admin_logic/edit_categories/edit_category_cubit.dart';
import 'package:admin_dash_board/core/models/category_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/showMessage.dart';

class EditCategoryPage extends StatefulWidget {
  const EditCategoryPage({super.key, required this.categoryModel});
  final CategoryModel categoryModel;

  @override
  State<EditCategoryPage> createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  final TextEditingController nameController = TextEditingController();
  Uint8List? imageBytes;
  String? imageName;
  bool imageChanged = false;

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.single.bytes != null) {
      setState(() {
        imageBytes = result.files.single.bytes;
        imageName = result.files.single.name;
        imageChanged = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.categoryModel.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تعديل الفئات")),
      body: Center(
        child: BlocConsumer<EditCategoryCubit, EditCategoryState>(
          builder: (context, state) {





            Future<void> onSave() async {
              final cubit = context.read<EditCategoryCubit>();

              if (nameController.text.trim().isEmpty) {
                ShowMessage.showToast("يرجى كتابة اسم القسم");
                return;
              }

              // إذا تم تغيير الصورة، ارفعها أولا وانتظر النتيجة في الـ listener
              if (imageChanged && imageBytes != null && imageName != null) {
                await cubit.uploadImage(
                  image: imageBytes!,
                  imageName: DateTime.now()
                      .toIso8601String()
                      .replaceAll(':', '-')
                      .replaceAll('.', '-') +
                      imageName!,
                  bucketName: 'categories',
                  delete_image_url: widget.categoryModel.deleteImage ?? '',
                );
              } else {
                // إذا لم يتم تغيير الصورة، فقط عدل القسم
                final updatedCategory = widget.categoryModel.copyWith(
                  name: nameController.text.trim(),
                );
                await cubit.EditCategory(category: updatedCategory);
              }
            }



            if (state is EditCategoryLoading || state is UploadImageLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "تعديل القسم",
                      style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 32),
                    GestureDetector(
                      onTap: pickImage,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: imageBytes != null
                                ? MemoryImage(imageBytes!)
                                : (widget.categoryModel.imageUrl != null
                                ? NetworkImage(
                                widget.categoryModel.imageUrl!)
                            as ImageProvider
                                : null),
                            child: (imageBytes == null &&
                                widget.categoryModel.imageUrl == null)
                                ? const Icon(Icons.add_a_photo, size: 30)
                                : null,
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: 100,
                            child: TextField(
                              controller: nameController,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                hintText: "اسم القسم",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: onSave,
                      child: Text( "تحديث القسم"),
                    ),
                  ],
                ),
              );
            }
          },
            listener: (context, state) async {
              if (state is UploadImageSuccess) {
                final cubit = context.read<EditCategoryCubit>();

                final updatedCategory = widget.categoryModel.copyWith(
                  name: nameController.text.trim(),
                  imageUrl: cubit.path, // الرابط الجديد للصورة
                  deleteImage: cubit.delete_path, // الرابط القديم المحذوف
                );

                await cubit.EditCategory(category: updatedCategory);
              }

              if (state is EditCategorySuccess) {
                ShowMessage.showToast("تم تحديث القسم بنجاح");
                Navigator.pop(context, true);
              }

              if (state is EditCategoryError) {
                ShowMessage.showToast("حدث خطأ أثناء التحديث");
              }
            }

        ),
      ),
    );
  }
}
