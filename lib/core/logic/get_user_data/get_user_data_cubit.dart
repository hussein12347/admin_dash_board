// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// import '../../api_services/api_services.dart';
// import '../../models/user_model.dart';
//
// part 'get_user_data_state.dart';
//
// class GetUserDataCubit extends Cubit<GetUserDataState> {
//   GetUserDataCubit() : super(GetUserDataInitial());
//   final ApiServices _api = ApiServices();
//   final SupabaseClient _supabase = Supabase.instance.client;
//
//   UserModel? userModel;
//   bool _isDataFetched = false;
//   bool _isLoading = false;
//
//   Future<UserModel?> getUserData() async {
//     if (_isDataFetched) {
//       emit(GetUserDataSuccess(userModel!));
//       return userModel;
//     }
//     if (_isLoading) return null;
//
//     _isLoading = true;
//     emit(GetUserDataLoading());
//
//     try {
//       final currentUser = _supabase.auth.currentUser;
//       if (currentUser == null) {
//         await clearUserData();
//         emit(GetUserDataInitial());
//         return null;
//       }
//
//       final cachedUser = await _getCachedUserData();
//       if (cachedUser != null && cachedUser.id == currentUser.id) {
//         userModel = cachedUser;
//         emit(GetUserDataSuccess(userModel!));
//         return userModel;
//       }
//
//       final response = await _api.getData(
//         path: "users?select=*&id=eq.${currentUser.id}",
//       );
//
//       final userData = _validateResponse(response);
//       userModel = UserModel.fromJson(userData);
//
//       await _cacheUserData(userModel!);
//
//       emit(GetUserDataSuccess(userModel!));
//       return userModel;
//     } catch (e) {
//       final cachedUser = await _getCachedUserData();
//       if (cachedUser != null) {
//         userModel = cachedUser;
//         emit(GetUserDataSuccess(userModel!));
//         return userModel;
//       }
//
//       emit(GetUserDataError(e.toString()));
//       return null;
//     } finally {
//       _isLoading = false;
//       _isDataFetched = true;
//     }
//   }
//
//   Map<String, dynamic> _validateResponse(dynamic response) {
//     if (response.data == null || response.data.isEmpty) {
//       throw Exception('No user data available');
//     }
//     return response.data[0];
//   }
//
//   Future<void> _cacheUserData(UserModel user) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('user_data_id', user.id);
//     await prefs.setString('user_data_name', user.name);
//     await prefs.setString('user_data_email', user.email);
//   }
//
//   Future<UserModel?> _getCachedUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final id = prefs.getString('user_data_id');
//     final name = prefs.getString('user_data_name');
//     final email = prefs.getString('user_data_email');
//
//     if (id == null || name == null || email == null) return null;
//
//     return UserModel(
//       id: id,
//       name: name,
//       email: email,
//     );
//   }
//
//   Future<void> clearUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('user_data_id');
//     await prefs.remove('user_data_name');
//     await prefs.remove('user_data_email');
//     userModel = null;
//     _isDataFetched = false;
//     emit(GetUserDataInitial());
//   }
// }