import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/adapter/adapter.dart';
import 'package:todo_app/controller/store_hive/operetions.dart';
import 'package:todo_app/model/model.dart';
import 'package:todo_app/view/presentetion/spalsh_screen/splash.dart';

void main()async {
   await Hive.initFlutter();

  // Register your custom adapter for the Todo class
  if (!Hive.isAdapterRegistered(CustomNoteAdapter().typeId)) {
    Hive.registerAdapter(CustomNoteAdapter());


  }
   await Hive.openBox<Note>('notes');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>CrudOpretion())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
         
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreeen(),
      ),
    );
  }
}


