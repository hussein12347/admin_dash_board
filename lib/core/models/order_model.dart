import 'package:admin_dash_board/core/models/shipping_address_model.dart';

import 'chart_entity.dart';

class OrderModel{
  final CarEntity carEntity;
  final bool? payWithCash;
  final ShippingAddressModel? shippingAddressModel;

  OrderModel({ this.shippingAddressModel,  this.payWithCash, required this.carEntity});
}