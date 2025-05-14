import 'package:admin_dash_board/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../add_category/views/ad_category_view.dart';
import '../../add_offers/views/add_offer_view.dart';
import '../../add_products_view/views/app_product_view.dart';
import '../../edit_categories/views/edit_categories_view.dart';
import '../../edit_offer/views/edit_offer_view.dart';
import '../../edit_product/views/edit_products_views.dart';
import '../../myOrders_screen/views/my_orders_view.dart';
import '../../send_notificaton/send_notification.dart';
import '../../show_comments/views/edit_products_views.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: LayoutBuilder(
        builder: (context, constraints) {


          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              padding: const EdgeInsets.all(24.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'الإجراءات الإدارية',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildDashboardButton(context, 'اضافة فئة', const AdCategoryView()),
                          _buildDashboardButton(context, 'تعديل الفئات', const EditCategoriesView()),

                          _buildDashboardButton(context, 'اضافة منتج', const AppProductView()),
                          _buildDashboardButton(context, 'تعديل المنتجات', const EditProductsViews()),
                          _buildDashboardButton(context, 'اضافة لوحة اعلانات', const AddOfferView()),
                          _buildDashboardButton(context, 'تعديل لوح الإعلانات', const EditOfferView()),
                          _buildDashboardButton(context, 'عرض الطلابات', const MyOrdersView()),
                          _buildDashboardButton(context, 'ارسال اشعار', const SendNotification()),
                          _buildDashboardButton(context, 'عرض التعليقات', const ShowCommentsViews()),
                        ],
                      ),
                      const SizedBox(height: 10),

                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDashboardButton(BuildContext context, String text, Widget page) {
    return SizedBox(
      width: 250,
      child: CustomButton(
        text: text,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        ),
      ),
    );
  }
}
