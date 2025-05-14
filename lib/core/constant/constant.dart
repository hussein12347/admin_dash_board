import 'dart:ui';

import 'package:intl/intl.dart';

bool kIsArabic(){
  return Intl.getCurrentLocale() =='ar';
}
const  Color kPrimaryColor = Color(0xff1f5e3b);
const  Color kSecondaryColor = Color(0xfff4a91f);
const  Color kLightSecondaryColor = Color(0xffF8C76D);
const  Color kLightPrimaryColor = Color(0xff2D9F5D);
const  Color kLight2PrimaryColor = Color(0xff5DB957);
const  Color kDarkPrimaryColor = Color(0xff1B5E37);
 double kHorizontalPadding=16;
 double kHeight16=16;
 double kHeight33=33;
 double kHeight24=24;
double kFontSize19 = 19;
double kFontSize13 = 13;
double kFontSize11 = 11;
double kFontSize12 = 12;
double kFontSize16 = 16;

int kCalculateDiscountPercentage(
{
required double
oldPrice
,
required double
newPrice
}) {
  if (oldPrice == 0) return 0;
  double discount = ((oldPrice - newPrice) / oldPrice) * 100;
  return discount.round();
}
