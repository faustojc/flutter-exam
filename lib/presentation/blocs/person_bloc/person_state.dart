part of 'person_cubit.dart';

final class PersonState with FastEquatable {
  final List<Person> persons;
  final int fetchAttempts;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasReachedMax;
  final String? error;

  PersonState({
    this.persons = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.fetchAttempts = 0,
    this.hasReachedMax = false,
    this.error,
  });

  PersonState copyWith({
    List<Person>? persons,
    bool? isLoading,
    bool? isLoadingMore,
    int? fetchAttempts,
    bool? hasReachedMax,
    String? error,
  }) {
    return PersonState(
      persons: persons ?? this.persons,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      fetchAttempts: fetchAttempts ?? this.fetchAttempts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error,
    );
  }

  @override
  List<Object?> get hashParameters => [
    persons,
    fetchAttempts,
    isLoading,
    isLoadingMore,
    hasReachedMax,
    error,
  ];
}
