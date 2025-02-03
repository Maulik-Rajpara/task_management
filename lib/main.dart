import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/presentation/pages/splash_page.dart';
import 'data/repositories/task_repository.dart';
import 'firebase_options.dart';
import 'observable/app_bloc_observer.dart';
import 'presentation/bloc/task_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider<TaskBloc>(
          create: (context1) =>
              TaskBloc(taskRepository: TaskRepository(), ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  const SplashPage(),

      ),
    );
  }
}
