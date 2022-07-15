import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_task/bloc/login/login_cubit.dart';
import 'package:test_task/bloc/register/register_cubit.dart';
import 'package:test_task/data/service/local/app_router.dart';
import 'package:test_task/presentation/auth/auth_page.dart';

import 'package:test_task/presentation/home/home_page.dart';

import 'bloc/all_blogs/all_blogs_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => BlocProvider(
        create: (context) => AllBlogsCubit()..getAllBlogs(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.white,
            colorScheme: ColorScheme.fromSwatch(accentColor: Colors.black),
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp),
                centerTitle: true,
                shadowColor: Colors.transparent),
            textTheme: TextTheme(
              headline1: GoogleFonts.monda(
                fontWeight: FontWeight.bold,
                fontSize: 25.sp,
              ),
              headline2: GoogleFonts.kalam(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
              headline3: GoogleFonts.oldStandardTt(
                fontSize: 18.sp,
              ),
              headline4: const TextStyle(),
            ).apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
          ),
          onGenerateRoute: AppRouter.onGenerateRoute,
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  body: Center(
                    child: Icon(
                      Icons.flutter_dash,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 30,
                    ),
                  ),
                );
              }
              if (snapshot.hasData) {
                return const HomePage();
              } else {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => LoginCubit(),
                    ),
                    BlocProvider(
                      create: (context) => RegisterCubit(),
                    ),
                  ],
                  child: const AuthPage(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
