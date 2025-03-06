import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exam/presentation/blocs/person_bloc/person_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final pixels = _scrollController.position.pixels;
    final maxScrollExtent = _scrollController.position.maxScrollExtent;

    return pixels == maxScrollExtent;
  }

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
  void initState() {
    super.initState();

    if (!kIsWeb && context.mounted) {
      _scrollController.addListener(() {
        if (_isBottom) BlocProvider.of<PersonCubit>(context).onLoadMore();
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<PersonCubit, PersonState>(
          builder: (_, state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    controller: _scrollController,
                    physics: AlwaysScrollableScrollPhysics(),
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
                  ),
                ),

                // For web with button
                if (kIsWeb)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child:
                        state.hasReachedMax
                            ? null
                            : ElevatedButton(
                              onPressed: () => BlocProvider.of<PersonCubit>(context).onLoadMore(),
                              child: const Text('Load more'),
                            ),
                  ),

                // For mobile loading
                if (!kIsWeb && state.isLoadingMore && state.persons.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Center(child: CircularProgressIndicator()),
                  ),

                if (state.hasReachedMax) const Center(child: Text('No more data')),
              ],
            );
          },
        ),
      ),
    ),
  );
}
