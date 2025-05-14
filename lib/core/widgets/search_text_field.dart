import 'package:admin_dash_board/core/widgets/type_products_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constant/constant.dart';
import '../logic/search/product_search_cubit.dart';

class CustomSearchTextField extends StatefulWidget {
  const CustomSearchTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    required this.filterOnPressed,
  });

  final VoidCallback filterOnPressed;
  final String hintText;
  final TextEditingController controller;

  final String? Function(String?)? validator;

  @override
  State<CustomSearchTextField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomSearchTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 9,
            spreadRadius: 0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        onSubmitted:
            (value) => Navigator.push(
              context,
              DialogRoute(
                context: context,
                builder:
                    (context) => BlocProvider(
                      create:
                          (context) =>
                              ProductSearchCubit()
                                ..getStandardProductData(search_query: value),
                      child: BlocBuilder<ProductSearchCubit,ProductSearchState>(
                        builder: (context, state) {
                          if(state is ProductSearchLoading){
                            return Scaffold(

                              appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,centerTitle: true,automaticallyImplyLeading: true,title: Text("نتائج البحث"),),

                              body:    const Center(child: CircularProgressIndicator(),)
                          ,);
                          }else if(state is ProductSearchSuccess){
                            if(state.products.isEmpty){
                              return Scaffold(

                                appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,centerTitle: true,automaticallyImplyLeading: true,title: Text("نتائج البحث"),),

                                body:     Center(child: SvgPicture.asset('assets/image/images/search_unavilable.svg'),)
                                ,);
                            }
                            return TypeProductsScreen(
                              products: state.products,
                              title:"نتائج البحث",
                              onRefresh: () async {
                                await context
                                    .read<ProductSearchCubit>()
                                    .getStandardProductData(search_query: value);
                              },
                            );
                          }else if(state is ProductSearchError){
                            return Scaffold(
                              appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,centerTitle: true,automaticallyImplyLeading: true,title: Text("نتائج البحث"),),

                              body: Center(child: Text(state.errorMessage),),);
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ),
              ),
            ),
        controller: widget.controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: widget.hintText,

          prefixIcon: SizedBox(
            height: 20,
            width: 20,
            child: Center(
              child: SvgPicture.asset('assets/image/images/search.svg'),
            ),
          ),
          suffixIcon: IconButton(
            onPressed: widget.filterOnPressed,
            icon: SvgPicture.asset(
              'assets/image/images/fillter.svg',
              colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(
            fontSize: kFontSize13,
            fontWeight: FontWeight.w400,
            color: const Color(0xff949D9E),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.2),
          ),
        ),
      ),
    );
  }
}
