import 'package:admin_dash_board/core/logic/auth_cubit.dart';
import 'package:admin_dash_board/views/login_screen/views/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/constant/constant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/logic/admin_logic/edit_product/edit_product_cubit.dart';
import 'core/logic/admin_logic/get_delevary_details/get_delivery_details_cubit.dart';
import 'core/logic/admin_logic/update_chart_status/update_chart_status_cubit.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web, // هذه هي الطريقة الصحيحة لتمرير الخيارات
  );
  await Supabase.initialize(
    url: 'https://bomnvaxxvzrzwkabeuse.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJvbW52YXh4dnpyendrYWJldXNlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQwMDYzMTIsImV4cCI6MjA1OTU4MjMxMn0.A5gkz2lcfNZuUDc_m1wQvPu_zdAwuvPw3MslXV2SSek',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),

    BlocProvider<GetDeliveryDetailsCubit>(
    create: (context) => GetDeliveryDetailsCubit()),
        BlocProvider<EditChartStatusCubit>(
    create: (context) => EditChartStatusCubit()),

        BlocProvider<EditProductCubit>(
          create: (context) => EditProductCubit()..getCategoryDetails(),
        )
      ],
      child: MaterialApp(
        locale: const Locale('ar'),
        supportedLocales: const [
          Locale('ar'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Cairo', // يفضل استخدام خط يدعم العربية مثل Cairo أو Noto
          colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
        ),
        home: const LoginView(),
      ),
    );
  }
}
