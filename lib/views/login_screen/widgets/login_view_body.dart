import 'package:admin_dash_board/views/dash_board_view/views/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant/constant.dart';
import '../../../core/logic/auth_cubit.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/showMessage.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      builder: (context, state) {
        AuthCubit cubit = context.read<AuthCubit>();
        return (state is LoginLoading )
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: kHeight33,
                        ),
                        CustomTextFormField(
                          validator: (value) {

                            if(value!="admin@gmail.com"){
                              return "أدخل البريد الإلكتروني الخاص بالأدمن";
                            }

                            if (value == null || value.isEmpty) {
                              return "أدخل البريد الإلكتروني";
                            }
                            final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                            if (!emailRegex.hasMatch(value)) {
                              return "البريد الإلكتروني غير صحيح";
                            }
                            return null;
                          },
                          hintText: "البريد الإلكتروني",
                          textInputType: TextInputType.emailAddress,
                          controller: emailController,
                        ),
                        SizedBox(
                          height: kHeight16,
                        ),
                        CustomTextFormField(
                          validator: (value) {

                            if (value == null || value.isEmpty) {
                              return "أدخل كلمة السر";
                            }  if (value !="111111") {
                              return "أدخل كلمة السر الخاصة بالأدمن";
                            }
                            if (value.length < 6) {
                              return "كلمة المرور غير صحيجة";
                            }
                            return null;
                          },

                          hintText: "كلمة المرور",
                          isPassword: true,
                          controller: passController,
                        ),
                        SizedBox(
                          height: kHeight16,
                        ),
                        SizedBox(
                          height: kHeight33,
                        ),
                        CustomButton(
                          onPressed: () async {
                        if(formKey.currentState!.validate()){
                          await cubit.login(
                              email: emailController.text,
                              password: passController.text,
                              context: context);
                        }

                          },
                          text: "تسجيل الدخول",
                        ),

                        SizedBox(
                          height: kHeight33,
                        ),

                        // SizedBox(
                        //   height: kHeight24,
                        // ),
                        // SocialLoginButton(
                        //   onPressed: () async {
                        //     await cubit.facebookSignIn();
                        //   },
                        //   image: 'assets/image/images/facebook.svg',
                        //   title: S.of(context).login_with_facebook,
                        // ),
                      ],
                    ),
                  ),
                ),
              );
      },
      listener: (context, state) {
        if (state is LoginError ) {
          ShowMessage.showToast(state.errorMessage);

        }
        // if(state is LoginSuccess|| state is GoogleLoginSuccess || state is FacebookLoginSuccess){
          if(state is LoginSuccess|| state is GoogleLoginSuccess ){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardView(),));
          }
        }
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }
}
