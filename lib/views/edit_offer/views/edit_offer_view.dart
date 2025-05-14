import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/admin_logic/edit_offers/edit_offer_cubit.dart';
import '../widgets/edit_offer_body.dart';

class EditOfferView extends StatelessWidget {
  const EditOfferView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditOfferCubit>(
      create: (context) {
        final cubit = EditOfferCubit();
        cubit.getStandardProductData(); // And this as well
        cubit.getOffersDetails();  // Assuming you need to call this
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(title: Text("تعديل لوحة الإعلانات"), centerTitle: true),
        body: EditOfferBody(),
      ),
    );
  }
}
