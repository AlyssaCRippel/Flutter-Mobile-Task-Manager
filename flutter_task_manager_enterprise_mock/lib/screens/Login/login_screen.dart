import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/login_cubit.dart';
import '../../models/loginState_model.dart';
import './login_form.dart';
import '../task_screen.dart';
import '../../cubits/task_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == LoginStatus.success,
      listener: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: context.read<TaskCubit>(),
                child: const TaskScreen(),
              ),
            ),
          );
        });
      },

      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          switch (state.status) {
            case LoginStatus.success:
            case LoginStatus.loading:
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            case LoginStatus.failure:
            case LoginStatus.initial:
              return Scaffold(
                body: LoginForm(
                  errorMessage: state.status == LoginStatus.failure
                      ? state.errorMessage
                      : null,
                ),
              );
        
          }
        },
      ),
    );
  }
}
