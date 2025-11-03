import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gbook_mobile/domain/usecases/get_book_by_id.dart';
import 'book_detail_event.dart';
import 'book_detail_state.dart';

class BookDetailBloc extends Bloc<BookDetailEvent, BookDetailState> {
  final GetBookById getBookById;

  BookDetailBloc(this.getBookById) : super(BookDetailInitial()) {
    on<LoadBookDetail>((event, emit) async {
      emit(BookDetailLoading());
      try {
        final book = await getBookById(event.bookId);
        emit(BookDetailLoaded(book));
      } catch (e) {
        emit(BookDetailError(e.toString()));
      }
    });
  }
}