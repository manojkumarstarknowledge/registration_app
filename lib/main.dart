import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'registration_provider.dart';
import 'details_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => RegistrationProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  final GlobalKey<FormState> formKey =
  GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider =
    context.watch<RegistrationProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
                validator: provider.validateName,
                onChanged: provider.setName,
              ),

              const SizedBox(height: 15),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: provider.validateEmail,
                onChanged: provider.setEmail,
              ),

              const SizedBox(height: 15),

              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                validator: provider.validatePassword,
                onChanged: provider.setPassword,
              ),

              const SizedBox(height: 20),

              if (provider.errorMessage.isNotEmpty)
                Text(
                  provider.errorMessage,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),

              const SizedBox(height: 20),

              provider.isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!
                      .validate()) {
                    bool success =
                    await context
                        .read<
                        RegistrationProvider>()
                        .register();

                    if (success) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              DetailsScreen(
                                name:
                                provider.name,
                                email:
                                provider.email,
                              ),
                        ),
                      );
                    }
                  }
                },
                child: const Text(
                  "Register",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}