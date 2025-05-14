import 'package:admin_dash_board/core/constant/constant.dart';
import 'package:admin_dash_board/core/logic/admin_logic/get_delevary_details/get_delivery_details_cubit.dart';
import 'package:admin_dash_board/core/widgets/custom_button.dart';
import 'package:admin_dash_board/core/widgets/showMessage.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/admin_logic/update_chart_status/update_chart_status_cubit.dart';
import '../../../core/models/cart_model.dart';

class OrderDetailScreen extends StatefulWidget {
  final CartModel cartModel;
  const OrderDetailScreen({super.key, required this.cartModel});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int selectedStatusIndex = 0; // لحفظ الحالة المختارة

  final List<String> deliveryStatuses = [
    'تتبع الطلب',
    'قبول الطلب',
    'تم شحن الطلب',
    'خرج للتوصيل',
    'تم التسليم',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedStatusIndex = widget.cartModel.status-2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تفاصيل الطلب"),
        centerTitle: true,
      ),
      body: BlocConsumer<EditChartStatusCubit,EditChartStatusState>(
          listener: (BuildContext context, EditChartStatusState state) async {
            if(state is Error){
              ShowMessage.showToast("حدث خطأ ما حاول لاحقا");
            }
            if(state is  UpdateChartStatusSuccess){
              await context.read<GetDeliveryDetailsCubit>().getGetDeliveryDetails();
              Navigator.pop(context);
              ShowMessage.showToast("تم تحديث حالة الطلب بنجاح");
            }
          },
        builder:(context, state) => (state is UpdateChartStatusLoading ) ? Center( child: CircularProgressIndicator(),) : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ بيانات الطلب
              _buildOrderInfo(),
              const SizedBox(height: 16),

              // ✅ حالة التوصيل (حالية مختارة)
              Text(
                "حالة التوصيل:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: List.generate(deliveryStatuses.length, (index) {
                  return ChoiceChip(
                    label: Text(deliveryStatuses[index]),
                    selected: selectedStatusIndex == index,
                    selectedColor: kLight2PrimaryColor,
                    onSelected: (selected) {
                      setState(() {
                        selectedStatusIndex = index;
                      });
                      print('تم اختيار: $selectedStatusIndex');
                    },
                  );
                }),
              ),
              const SizedBox(height: 16),

              // ✅ المنتجات
              Expanded(
                child: ListView.builder(
                  itemCount: widget.cartModel.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = widget.cartModel.cartItems[index];
                    return _buildCartItem(item);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(onPressed: () => context.read<EditChartStatusCubit>().updateStatus(widget.cartModel.cartItems[0].orderId, selectedStatusIndex+2), text: "تحديث حالة الطلب"),
      ),
    );
  }

  Widget _buildOrderInfo() {
    final model = widget.cartModel;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'رقم الطلب: ${model.number}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
        ),
        const SizedBox(height: 8),
        Text('تاريخ الطلب: ${model.createdAt}'),
        Text('العميل: ${model.name} (${model.phone})'),
        Text('العنوان: ${model.address}'),
        const SizedBox(height: 8),
        Text(
          'الحالة: ${model.isPaid ? "مدفوع" : "غير مدفوع"}',
          style: TextStyle(
            color: model.isPaid ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'إجمالي السعر: ${model.totalPrice - 30} جنية + 30 جنية توصيل = ${model.totalPrice} جنية',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal),
        ),
      ],
    );
  }

  Widget _buildCartItem(CartItemModel item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: item.product.imageUrl ?? '',
                width: 80,
                height: 80,
                fit: BoxFit.fill,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.broken_image),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.productName,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                  const SizedBox(height: 4),
                  Text('السعر: ${item.product.price} جنية'),
                  Text(
                    'الوصف: ${item.product.description}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text('الكمية: ${item.quantity}'),
                  const SizedBox(height: 4),
                  Text(
                    'الإجمالي: ${(double.parse(item.product.price) * item.quantity).toStringAsFixed(2)} جنية',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
