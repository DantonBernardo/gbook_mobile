import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/search_books.dart' as usecases;
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final usecases.SearchBooks searchBooks;

  SearchBloc(this.searchBooks) : super(SearchInitial()) {
    on<SearchBooks>((event, emit) async {
      if (event.query.trim().isEmpty) {
        emit(SearchInitial());
        return;
      }

      emit(SearchLoading());
      try {
        final books = await searchBooks(event.query);
        if (books.isEmpty) {
          emit(SearchEmpty());
        } else {
          emit(SearchLoaded(books, event.query));
        }
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    });

    on<ClearSearch>((event, emit) {
      emit(SearchInitial());
    });
  }
}