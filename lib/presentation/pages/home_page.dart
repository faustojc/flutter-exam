import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exam/presentation/blocs/person_bloc/person_cubit.dart';
import 'package:flutter_exam/presentation/components/person_list.dart';

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

  void _onScroll() {
    if (_isBottom) BlocProvider.of<PersonCubit>(context).onLoadMore();
  }

  @override
  void initState() {
    super.initState();

    if (!kIsWeb) {
      _scrollController.addListener(_onScroll);
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
      floatingActionButton:
          (!kIsWeb)
              ? null
              : FloatingActionButton(
                onPressed:
                    () => BlocProvider.of<PersonCubit>(context).onInitialize(isRefreshing: true),
                child: BlocBuilder<PersonCubit, PersonState>(
                  buildWhen: (prev, curr) => prev.isRefreshing != curr.isRefreshing,
                  builder: (_, state) {
                    if (state.isRefreshing) {
                      return const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return const Icon(Icons.refresh);
                    }
                  },
                ),
              ),
      body: RefreshIndicator(
        onRefresh: () async {
          Future<void> personState = BlocProvider.of<PersonCubit>(context)
              .stream //
              .firstWhere((state) => !state.isRefreshing && !state.isLoading);

          BlocProvider.of<PersonCubit>(context).onInitialize(isRefreshing: true);

          return personState;
        },
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            BlocBuilder<PersonCubit, PersonState>(
              buildWhen: (prev, curr) => prev != curr,
              builder: (_, state) {
                if (state.isLoading && !state.isRefreshing) {
                  return SliverFillRemaining(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  );
                }

                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PersonList(state.persons),

                        // For web with button
                        if (kIsWeb)
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child:
                                state.hasReachedMax
                                    ? null
                                    : ElevatedButton(
                                      onPressed:
                                          !state.isLoadingMore
                                              ? () =>
                                                  BlocProvider.of<PersonCubit>(context).onLoadMore()
                                              : null,
                                      child:
                                          !state.isLoadingMore
                                              ? const Text('Load more')
                                              : const SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: CircularProgressIndicator(),
                                              ),
                                    ),
                          ),

                        // For mobile loading
                        if (!kIsWeb && state.isLoadingMore && state.persons.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: const Center(child: CircularProgressIndicator()),
                          ),

                        if (state.hasReachedMax) const Center(child: Text('No more data')),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}
