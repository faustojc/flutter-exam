part of 'person_cubit.dart';

final class PersonState extends Equatable {
  final List<Person> persons;
  final int fetchAttempts;
  final bool isLoading;
  final bool isLoadingMore;
  final bool isRefreshing;
  final bool hasReachedMax;
  final String? error;

  const PersonState({
    this.persons = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isRefreshing = false,
    this.fetchAttempts = 0,
    this.hasReachedMax = false,
    this.error,
  });

  PersonState copyWith({
    List<Person>? persons,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isRefreshing,
    int? fetchAttempts,
    bool? hasReachedMax,
    String? error,
  }) {
    return PersonState(
      persons: persons ?? this.persons,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      fetchAttempts: fetchAttempts ?? this.fetchAttempts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    persons,
    fetchAttempts,
    isLoading,
    isLoadingMore,
    isRefreshing,
    hasReachedMax,
    error,
  ];
}
