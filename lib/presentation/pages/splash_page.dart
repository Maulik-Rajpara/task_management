import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/presentation/pages/task_list_screen.dart';

import '../widgets/splash_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    redirectScreen(context);
  }
  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Scaffold(body: SplashWidget()));
  }
  void redirectScreen(context) async{
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>
          const TaskListScreen()),
    );

  }
}
