import 'package:admin_dash_board/core/constant/constant.dart';
import 'package:admin_dash_board/core/logic/admin_logic/send_notification/send_notification_cubit.dart';
import 'package:admin_dash_board/core/widgets/custom_button.dart';
import 'package:admin_dash_board/core/widgets/custom_text_field.dart';
import 'package:admin_dash_board/core/widgets/showMessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendNotification extends StatelessWidget {
  const SendNotification({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController objectController = TextEditingController();

    return BlocProvider<SendNotificationCubit>(
      create: (context) => SendNotificationCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("إرسال إشعار"),
          centerTitle: true,
          elevation: 0,
        ),
        body: BlocConsumer<SendNotificationCubit, SendNotificationState>(
          builder: (context, state) {
            if (state is SendNotificationLoading ||
                state is SendNotificationError) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Center(
                child: SingleChildScrollView(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    // يمنع التمدد الزائد على الشاشات الكبيرة
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "العنوان:",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        CustomTextFormField(
                          hintText: "أدخل عنوان الإشعار",
                          controller: titleController,
                        ),
                        const SizedBox(height: 32),

                        Text(
                          "الموضوع:",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        CustomTextFormField(
                          hintText: "أدخل نص الإشعار",
                          controller: objectController,
                        ),
                        const SizedBox(height: 40),

                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 200,
                            child: CustomButton(
                              onPressed: () async {
                                await context
                                    .read<SendNotificationCubit>()
                                    .sendNotification(
                                      title: titleController.text,
                                      object: objectController.text,
                                    );
                              },
                              text: "إرسال الإشعار",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
          listener: (context, state) {
            if(state is SendNotificationSuccess){
              ShowMessage.showToast("تم ارسال الإشعار بنجاح");
            }
          },
        ),
      ),
    );
  }
}
