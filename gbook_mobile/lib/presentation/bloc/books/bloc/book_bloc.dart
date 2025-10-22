import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecases/get_all_books.dart';
import 'book_event.dart';
import 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final GetAllBooks getAllBooks;

  BookBloc(this.getAllBooks) : super(BookInitial()) {
    on<LoadAllBooks>((event, emit) async {
      emit(BookLoading());
      try {
        final books = await getAllBooks();
        emit(BookLoaded(books));
      } catch (e) {
        emit(BookError(e.toString()));
      }
    });
  }
}
