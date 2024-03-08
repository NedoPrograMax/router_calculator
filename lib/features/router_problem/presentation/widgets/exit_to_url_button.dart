import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:router/features/url_setter/presentation/cubits/url_cubit/url_cubit.dart';
import 'package:router/features/url_setter/presentation/screens/url_setter_screen.dart';
import 'package:router/injection_container.dart';

class ExitToUrlButton extends StatelessWidget {
  const ExitToUrlButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const UrlSetterScreen()),
          (route) => false,
        );
      },
      icon: const Icon(
        Icons.exit_to_app,
      ),
    );
  }
}
