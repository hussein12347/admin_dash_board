import 'dart:typed_data';
import 'package:admin_dash_board/core/constant/constant.dart';
import 'package:admin_dash_board/core/logic/admin_logic/add_categories/add_categories_cubit.dart';
import 'package:admin_dash_board/core/widgets/showMessage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdCategoryBody extends StatefulWidget {
  const AdCategoryBody({super.key});

  @override
  State<AdCategoryBody> createState() => _AdCategoryBodyState();
}

class _AdCategoryBodyState extends State<AdCategoryBody> {
  final TextEditingController nameController = TextEditingController();
  Uint8List? imageBytes;
  String? imageName;

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
    return BlocConsumer<AddCategoriesCubit,AddCategoriesState>(
      builder: (BuildContext context, AddCategoriesState state) {
        Future<void> onSave() async {
          final name = nameController.text.trim();

          if (name.isEmpty) {
            ShowMessage.showToast("يرجى إدخال اسم القسم");

            return;
          }

          if (imageBytes == null) {
            ShowMessage.showToast("يرجى اختيار صورة");


            return;
          }

          // TODO: ارسال البيانات


          if( state is UploadImageSuccess ){
              await context.read<AddCategoriesCubit>().addCategory(imageUrl: state.path, name: name, deleteImageUrl: state.delete_path);
            ShowMessage.showToast("تم حفظ القسم",backgroundColor: kPrimaryColor);
            Navigator.pop(context);

          }else{
            await context.read<AddCategoriesCubit>().uploadImage(image: imageBytes!, imageName: DateTime.now().toIso8601String().replaceAll(':', '-').replaceAll('.', '-') + imageName!, bucketName: 'categories');
          }

        }

        if(state is AddCategoriesLoading || state is UploadImageLoading){
          return Center(child: CircularProgressIndicator());
        }else{
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "إضافة قسم",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: pickImage,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[300],
                            backgroundImage:
                            imageBytes != null ? MemoryImage(imageBytes!) : null,
                            child: imageBytes == null
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
                  ],
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: onSave,
                  child:  (state is UploadImageSuccess)?Text("حفظ القسم"):Text("أرفع الصورة"),
                ),
              ],
            ),
          );
        }
      },
      listener: (BuildContext context, AddCategoriesState state) {  },
      
    );
  }
}
