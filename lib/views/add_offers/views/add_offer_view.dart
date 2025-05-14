import 'package:admin_dash_board/core/logic/admin_logic/add_offers/add_offer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/add_offer_body.dart';

class AddOfferView extends StatelessWidget {
  const AddOfferView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddOfferCubit>(
      create:(context) => AddOfferCubit()..getStandardProductData(),
      child: Scaffold(
        appBar: AppBar(title: Text("أضف لوحة إعلانات"), centerTitle: true),
        body: AddOfferBody(),
      ),
    );
  }
}
