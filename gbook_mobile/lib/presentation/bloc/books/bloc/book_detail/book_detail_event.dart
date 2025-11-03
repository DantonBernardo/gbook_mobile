abstract class BookDetailEvent {}

class LoadBookDetail extends BookDetailEvent {
  final int bookId;
  LoadBookDetail(this.bookId);
}