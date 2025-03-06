import 'package:fast_equatable/fast_equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exam/model/person.dart';
import 'package:flutter_exam/repository/person_repository.dart';

part 'person_state.dart';

class PersonCubit extends Cubit<PersonState> {
  final PersonRepository _personRepository;

  PersonCubit(this._personRepository) : super(PersonState());

  Future<void> onInitialize({bool isRefreshing = false}) async {
    emit(state.copyWith(isLoading: true, isRefreshing: isRefreshing));

    try {
      final persons = await _personRepository.fetchPersons();

      emit(state.copyWith(persons: persons, isLoading: false, isRefreshing: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false, isRefreshing: false));
    }
  }

  Future<void> onLoadMore() async {
    emit(state.copyWith(isLoadingMore: true));

    try {
      if (state.hasReachedMax) {
        emit(state.copyWith(isLoadingMore: false));
        return;
      }

      final quantity = state.persons.length;
      final persons = await _personRepository.fetchPersons(quantity: quantity + 20);
      final existingPersons = state.persons;

      if (existingPersons.isNotEmpty) {
        existingPersons.insertAll(
          existingPersons.length - 1,
          persons.sublist(existingPersons.length),
        );
      }

      emit(
        state.copyWith(
          persons: existingPersons,
          isLoadingMore: false,
          hasReachedMax: state.fetchAttempts == 4,
          fetchAttempts:
              (quantity == persons.length) ? state.fetchAttempts + 1 : state.fetchAttempts,
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoadingMore: false));
    }
  }
}
