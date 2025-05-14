import 'package:admin_dash_board/core/logic/admin_logic/edit_offers/edit_offer_cubit.dart';
import 'package:admin_dash_board/core/models/offer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'edit_offer_item.dart';
import 'edit_view.dart';

class EditOfferBody extends StatelessWidget {
  const EditOfferBody({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<EditOfferCubit,EditOfferState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<EditOfferCubit>(context);
        if(state is GetOfferDetailsLoading || state is GetProductDetailsLoading|| state is DeleteOfferLoading){
          return Center(child: CircularProgressIndicator(),);
        }else{
          final List<OfferModel> offers = cubit.offersModelList;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              itemCount: offers.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                mainAxisExtent: 200,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, index) {
                final item = offers[index];
                return EditOfferItem(
                  name: item.name ?? '',
                  imageUrl: item.imageUrl,
                  onDelete: () async {
                    await cubit.deleteOffer(offer: offers[index]);
                  },
                  onEdit: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (_) => EditOfferCubit(),
                          child:EditView(offerModel: offers[index],)
                        ),
                      ),
                    ).then((value) {
                      if (value == true) {
                        // قم بإعادة تحميل البيانات
                        context.read<EditOfferCubit>().getOffersDetails();
                      }
                    });


                  },
                );
              },
            ),
          );
        }
      } ,
    );
  }
}
