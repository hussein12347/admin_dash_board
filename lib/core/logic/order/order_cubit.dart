// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
//
// import '../../models/chart_entity.dart';
// import '../../models/order_model.dart';
// import '../../models/shipping_address_model.dart';
//
// part 'order_state.dart';
//
// class OrderCubit extends Cubit<OrderState> {
//   OrderCubit() : super(OrderInitial());
//
//   OrderModel? _orderModel;
//   CarEntity? _carEntity;
//   bool? _payWithCash;
//   String? _name;
//   String? _phone;
//   String? _address;
//
//   // Getters
//   OrderModel? get orderModel => _orderModel;
//   CarEntity? get carEntity => _carEntity;
//   bool? get payWithCash => _payWithCash;
//   String? get name => _name;
//   String? get phone => _phone;
//   String? get address => _address;
//
//   // Individual setters
//   void setCarEntity(CarEntity car) {
//     _carEntity = car;
//     emit(OrderPartialUpdated());
//   }
//
//   void setPayWithCash(bool payCash) {
//     _payWithCash = payCash;
//     emit(OrderPartialUpdated());
//   }
//
//   void setName(String name) {
//     _name = name;
//     emit(OrderPartialUpdated());
//   }
//
//   void setPhone(String phone) {
//     _phone = phone;
//     emit(OrderPartialUpdated());
//   }
//
//   void setAddress(String address) {
//     _address = address;
//     emit(OrderPartialUpdated());
//   }
//
//   // Final assembly
//   void updateOrder() {
//     if (_carEntity == null ||
//         _payWithCash == null ||
//         _name == null ||
//         _phone == null ||
//         _address == null) {
//       if (_carEntity == null) print("CarEntity is null");
//       if (_payWithCash == null) print("Payment method not selected");
//       if (_name == null) print("Name is null");
//       if (_phone == null) print("Phone is null");
//       if (_address == null) print("Address is null");
//
//
//       emit(OrderError("يجب تعبئة جميع البيانات قبل إنشاء الطلب"));
//       return;
//     }
//
//     _orderModel = OrderModel(
//       carEntity: _carEntity!,
//       payWithCash: _payWithCash!,
//       shippingAddressModel: ShippingAddressModel(
//         name: _name!,
//         phone: _phone!,
//         address: _address!,
//       ),
//     );
//
//     emit(OrderUpdated(_orderModel!));
//   }
//
//   void clearOrder() {
//     _orderModel = null;
//     _carEntity = null;
//     _payWithCash = null;
//     _name = null;
//     _phone = null;
//     _address = null;
//
//     emit(OrderInitial());
//   }
// }
