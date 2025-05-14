import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant/constant.dart';
import '../../../core/logic/admin_logic/get_delevary_details/get_delivery_details_cubit.dart';
import '../../../core/logic/admin_logic/update_chart_status/update_chart_status_cubit.dart';
import '../widgets/my_order_item.dart';
import '../widgets/order_details_screen.dart';

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _MyOrdersViewContent();
  }
}

class _MyOrdersViewContent extends StatefulWidget {
  const _MyOrdersViewContent();

  @override
  State<_MyOrdersViewContent> createState() => _MyOrdersViewContentState();
}
class _MyOrdersViewContentState extends State<_MyOrdersViewContent> {
  int? _selectedStatus; // Tracks the selected filter status (int or null for All)



  // List of dropdown options (including "All")
  final List<MapEntry<dynamic, String>> _statusOptions = [
    const MapEntry(null, 'الكل'), // null represents "All" orders
    const MapEntry(2, 'تتبع الطلب'),
    const MapEntry(3, 'قبول الطلب'),
    const MapEntry(4, 'تم شحن الطلب'),
    const MapEntry(5, 'خرج للتوصيل'),
    const MapEntry(6, 'تم التسليم'),
  ];

  @override
  void initState() {
    super.initState();
    context.read<GetDeliveryDetailsCubit>().getGetDeliveryDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:  Text(
            "الطلبات",
            style: TextStyle(
              fontSize: kFontSize19,
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
        ),
        body: Column(
          children: [
            // Filter Dropdown
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: DropdownButton<dynamic>(
                value: _selectedStatus,
                hint: const Text('تصفية حسب الحالة'),
                isExpanded: true,
                items: _statusOptions.map((entry) {
                  return DropdownMenuItem<dynamic>(
                    value: entry.key,
                    child: Text(entry.value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedStatus = value;
                  });
                },
              ),
            ),
            // Orders Grid
            Expanded(
              child: BlocBuilder<GetDeliveryDetailsCubit, GetDeliveryDetailsState>(
                builder: (context, state) {
                  if (state is GetDeliveryDetailsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GetDeliveryDetailsSuccess) {
                    final cartModel = state.cartModel;

                    // Apply filter based on selected status
                    final filteredCartModel = _selectedStatus == null
                        ? cartModel
                        : cartModel
                        .where((cart) => cart.status == _selectedStatus)
                        .toList();

                    if (filteredCartModel.isEmpty) {
                      return const Center(
                        child: Text(
                          "لا توجد طلبات متاحة",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      );
                    }

                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final width = constraints.maxWidth;
                        final crossAxisCount = width >= 1200
                            ? 7
                            : width >= 900
                            ? 5
                            : width >= 600
                            ? 3
                            : 1;

                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: width < 600 ? 1.2 : 2.5,
                            ),
                            itemCount: filteredCartModel.length,
                            itemBuilder: (context, index) {
                              final cart = filteredCartModel[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        create: (_) => EditChartStatusCubit(),
                                        child: OrderDetailScreen(cartModel: cart),
                                      ),
                                    ),
                                  );
                                },
                                child: MyOrderItem(deliveryModel: cart),
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else if (state is GetDeliveryDetailsError) {
                    return Center(
                      child: Text(
                        state.messageError,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
