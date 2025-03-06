import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exam/presentation/blocs/person_bloc/person_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showScaffold(BuildContext context, String message) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    scaffoldMessenger.showMaterialBanner(
      MaterialBanner(
        content: Text(message, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
        backgroundColor: Theme.of(context).colorScheme.error,
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Theme.of(context).colorScheme.onPrimary),
            onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
          ),
        ],
      ),
    );

    Future.delayed(const Duration(seconds: 4), () => scaffoldMessenger.hideCurrentMaterialBanner());
  }

  @override
  Widget build(BuildContext context) => BlocListener<PersonCubit, PersonState>(
    listenWhen: (prev, curr) => prev != curr,
    listener: (context, state) {
      if (state.error != null) {
        _showScaffold(context, state.error!);
      }
    },
    child: Scaffold(
      appBar: AppBar(title: Text('Flutter Exam')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: BlocBuilder<PersonCubit, PersonState>(
          builder: (_, state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.separated(
              itemCount: state.persons.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final person = state.persons[index];

                return ListTile(
                  leading: CircleAvatar(
                    child: FastCachedImage(
                      url: person.image,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return const Icon(Icons.person);
                      },
                      loadingBuilder: (context, progress) {
                        return CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                          value: progress.progressPercentage.value,
                        );
                      },
                    ),
                  ),
                  title: Text(person.fullName),
                  subtitle: Text(person.email, style: TextStyle(fontSize: 12)),
                  tileColor: Theme.of(context).colorScheme.secondaryFixedDim,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                );
              },
            );
          },
        ),
      ),
    ),
  );
}
