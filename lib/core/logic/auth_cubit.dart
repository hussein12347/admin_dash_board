import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  SupabaseClient client = Supabase.instance.client;


  Future<void>login({required String email, required String password,required BuildContext context }) async{
   emit(LoginLoading());

    try {
      final AuthResponse res = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on AuthException catch (e) {
      String errorMessage;
      if (e.message.contains("Invalid login credentials")) {
        errorMessage = "الاميل غير صحح";
      } else {
        errorMessage = e.message;
      }
      print(" ++++++++ error signUp: $e");
      emit(LoginError(errorMessage));
    }
  }

  Future<void>signUp({required String name,required String email, required String password}) async{
   emit(SignupLoading());

    try {
      final AuthResponse res = await client.auth.signUp(
        email: email,
        password: password,
      );

      await addUserData(email: email, name: name, password: password);
      emit(SignupSuccess());
    } on AuthException catch (e) {
      print(" ++++++++ error signUp: $e");
      emit(SignupError(e.message));
      // TODO
    }
  }


  //
  // Future<AuthResponse> facebookSignIn() async {
  //   emit(FacebookLoginLoading());
  //
  //   try {
  //     final LoginResult result = await FacebookAuth.instance.login(
  //       permissions: ['email', 'public_profile'],
  //     );
  //
  //     if (result.status != LoginStatus.success || result.accessToken == null) {
  //       emit(FacebookLoginError());
  //       return AuthResponse();
  //     }
  //
  //     final accessToken = result.accessToken!.tokenString;
  //
  //     // Facebook authentication only provides access tokens, not ID tokens
  //     // We'll use the access token for both parameters since ID token is required
  //     AuthResponse response = await client.auth.signInWithIdToken(
  //       provider: OAuthProvider.facebook,
  //       idToken: accessToken,  // Using access token as ID token
  //       accessToken: accessToken,
  //     );
  //
  //     emit(FacebookLoginSuccess());
  //     return response;
  //   } catch (e) {
  //     emit(FacebookLoginError());
  //     return AuthResponse();
  //   }
  // }

Future<void> addUserData({
    required String email,
    required String name,
    required String password,
  })async {
    emit(UserDataAddedLoading());
    try {
      await client
          .from('users')
          .upsert({'email': email, 'name': name,'pass':password,'id':client.auth.currentUser!.id});
      emit(UserDataAddedSuccess());
    } on Exception catch (e) {
      log('UserDataAddedError$e');
      emit(UserDataAddedError(e.toString()));
    }
}

}


