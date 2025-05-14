// import 'package:bloc/bloc.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:meta/meta.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// import '../../api_services/api_services.dart';
// import '../../models/cart_item_entity_model.dart';
// import '../../models/product_model.dart';
//
// part 'chart_item_state.dart';
//
// class ChartItemCubit extends Cubit<ChartItemState> {
//   ChartItemCubit() : super(ChartItemInitial());
//
//   final ApiServices api = ApiServices();
//
//   void updateCartItem(CarItemEntity carItemEntity) {
//     emit(ChartItemUpdate(carItemEntity: carItemEntity));
//   }
//
//   Future<bool> isCurrentAvailable(CarItemEntity carItemEntity, BuildContext context) async {
//     final userId = Supabase.instance.client.auth.currentUser?.id;
//
//     final response = await api.getData(
//       path: 'products_table?select=*,favorite_products(*)&order=created_at.desc',
//     );
//
//     for (var product in response.data) {
//       final productModel = ProductModel.fromJson(product, userId!);
//
//       if (carItemEntity.product.productId == productModel.productId) {
//         final availableQty = int.tryParse(productModel.available_quantity) ?? 0;
//
//         if (availableQty > 0) {
//           if (carItemEntity.count <= availableQty) {
//             return true;
//           } else {
//             return false;
//           }
//         } else {
//           return false;
//         }
//       }
//     }
//
//     return false;
//   }
//
// }
