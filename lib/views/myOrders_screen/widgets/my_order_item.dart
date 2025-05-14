
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../core/constant/constant.dart';
import '../../../core/models/cart_model.dart';
import 'order_tracking_item.dart';

class MyOrderItem extends StatelessWidget {
  const MyOrderItem({super.key, required this.deliveryModel});

  final CartModel deliveryModel;
  @override
  Widget build(BuildContext context) {
    return  OrderTrackingItem(
      image: 'assets/image/tracking_images/order.svg',
      widget: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${"الطلب رقم"} ${deliveryModel.number}#",
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                style: TextStyle(
                  fontSize: kFontSize11,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff949D9E),
                ),

                     "${"تاريخ الطلب"} ${DateFormat("d MMMM, y", "ar").format(deliveryModel.createdAt)}"
              ),
            ],
          ),
          SizedBox(height: 5),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${"السعر الكلي"} ${deliveryModel.totalPrice}",
                style: TextStyle(
                  fontSize: kFontSize11,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff949D9E),
                ),
              ),
            ],
          ),
        ],
      ), isDone: deliveryModel.status>=1,
    );
  }
}
