import 'package:fast_equatable/fast_equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exam/model/person.dart';
import 'package:flutter_exam/repository/person_repository.dart';

part 'person_state.dart';

class PersonCubit extends Cubit<PersonState> {
  final PersonRepository _personRepository;

  PersonCubit(this._personRepository) : super(PersonState());

  Future<void> onInitialize() async {
    emit(state.copyWith(isLoading: true));

    try {
      final persons = await _personRepository.fetchPersons();

      emit(state.copyWith(persons: persons, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> onLoadMore() async {
    emit(state.copyWith(isLoadingMore: true));

    try {
      final quantity = state.persons.length;
      final persons = await _personRepository.fetchPersons(quantity: quantity + 20);

      emit(state.copyWith(persons: persons, isLoadingMore: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoadingMore: false));
    }
  }
}
