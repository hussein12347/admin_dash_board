import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderTrackingItem extends StatelessWidget {
  const OrderTrackingItem({super.key, required this.image, required this.widget, required this.isDone});

  final String image;
  final Widget widget;
  final bool isDone;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 12,
        bottom: 12,
        left: 13,
        right: 0,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 2, color: isDone?const Color(0xffEBF9F1):const Color(0xffF5F5F5)),
          borderRadius: BorderRadius.circular(8),
        ),
        color: isDone?const Color(0xffEBF9F1):const Color(0xffF5F5F5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 33,
            backgroundColor:isDone?const Color(0xffEBF9F1):const Color(0xffF5F5F5),
            child: SvgPicture.asset(
              image,
              color: isDone?const Color(0xff1B5E37):const Color(0xff868889),
            ),
          ),
          SizedBox(width: 20,),
          widget
        ],
      ),
    );
  }
}
