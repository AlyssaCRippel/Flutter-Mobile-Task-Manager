import 'package:flutter/material.dart';
import './Data/auth_repo.dart';
import './Data/user_repo.dart';
import './Data/task_repo.dart';
import 'screens/Login/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/login_cubit.dart';
import 'cubits/user_cubit.dart';
import 'cubits/task_cubit.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize repositories
    // These repositories handle data operations and are injected into the cubits
    final authRepo = AuthRepo();
    final userRepo = UserRepo();
    final taskRepo = TaskRepo();

    //multiple bloc providers to manage different states
    //they create instances of cubits that can be accessed throughout the app
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          create: (_) => UserCubit(userRepo),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(authRepo, context.read<UserCubit>()),
        ),
        BlocProvider<TaskCubit>(
          create: (context) => TaskCubit(taskRepo),
        ),
      ],
      // The MaterialApp widget is the root of the application
      // It sets up the app's theme, routes, and home screen
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
