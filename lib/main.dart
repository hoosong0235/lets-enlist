import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lets_enlist/controllers/chat_controller.dart';
import 'package:lets_enlist/controllers/enlist_controller.dart';
import 'package:lets_enlist/firebase_options.dart';
import 'package:lets_enlist/utilities/value.dart';
import 'package:lets_enlist/views/main_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  EnlistController.fetchRawEnlists();
  EnlistController.fetchLastestEnlists();
  runApp(const LetsEnlist());
}

class LetsEnlist extends StatelessWidget {
  const LetsEnlist({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double viewportWidth = MediaQuery.of(context).size.width;
    bool isMobile = viewportWidth <= WIDTHTRHESHOLD;
    ChatController.initialize(isMobile);

    return MaterialApp(
      title: 'Lets Enlist',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(primary: Color(0xFF536349)),
      ),
      home: const MainView(),
    );
  }
}
