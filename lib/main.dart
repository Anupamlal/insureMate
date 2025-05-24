import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insure_mate/db_helper/shared_preference/app_shared_preference.dart';
import 'package:insure_mate/providers/policy_provider/policy_provider.dart';
import 'package:insure_mate/screens/afterlogin_screens/1_home/add_policy_screen/service/add_policy_service.dart';
import 'package:insure_mate/screens/onboarding_screens/splash_screen/splash_screen.dart';
import 'package:insure_mate/theme/app_color.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // We're using the manual installation on non-web platforms since Google sign in plugin doesn't yet support Dart initialization.
  // See related issue: https://github.com/flutter/flutter/issues/96391

  // We store the app and auth to make testing with a named instance easier.
  await Firebase.initializeApp();
  await checkFirstRunAndForceLogoutIfNeeded();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PolicyProvider()),
        ChangeNotifierProvider(
          create:
              (context) => AddPolicyService(
                policyProvider: context.read<PolicyProvider>(),
              ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

Future<void> checkFirstRunAndForceLogoutIfNeeded() async {
  final loggedInPersonID = await AppSharedPreference.getLoggedInPersonId();

  if (loggedInPersonID == null) {
    await FirebaseAuth.instance.signOut();
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insure Mate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: AppColor.primarySwatch,
        ),
        fontFamily: 'Poppins',
      ),
      home: SplashScreen(),
    );
  }
}
