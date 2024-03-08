import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:router/core/helper/validators.dart';
import 'package:router/features/router_problem/presentation/screens/calculations_screen.dart';
import 'package:router/features/url_setter/presentation/cubits/url_cubit/url_cubit.dart';

import 'package:router/injection_container.dart';

class UrlSetterScreen extends StatefulWidget {
  const UrlSetterScreen({super.key});

  @override
  State<UrlSetterScreen> createState() => _UrlSetterScreenState();
}

class _UrlSetterScreenState extends State<UrlSetterScreen> {
  final formKey = GlobalKey<FormState>();
  final urlFieldController = TextEditingController();
  late final UrlCubit cubit;

  @override
  void initState() {
    cubit = sl();
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      cubit.getUrl();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UrlCubit, UrlState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is UrlData) {
          urlFieldController.text = state.url ?? "";
        }
        if (state is UrlSucess) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CalculationsScreen(),
            ),
          );
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Form(
                key: formKey,
                child: TextFormField(
                  controller: urlFieldController,
                  validator: validateUrl,
                  decoration: const InputDecoration(
                    hintText: "https://flutter.webspark.dev",
                    labelText: "Initial URL",
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: onStartButtonPressed,
                child: const Text("Start counting process"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onStartButtonPressed() {
    final url = urlFieldController.text;
    final isUrlValid = formKey.currentState?.validate();
    if (isUrlValid == true) {
      cubit.setUrl(url.trim());
    }
  }
}
