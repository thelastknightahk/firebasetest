import 'package:flutter/material.dart';
import 'package:hello_firebase/model/book.dart';
import 'package:hello_firebase/services/database_service.dart';
import 'package:hello_firebase/sharedfile/book_title.dart';
import 'package:provider/provider.dart';

class BookList extends StatefulWidget {
  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    final books = Provider.of<List<Book>>(context);
    List<Book> mybook = [];

    if (books != null) {
      mybook.addAll(books);
    }
    return  ListView.builder(
      itemCount: mybook.length,
      itemBuilder: (context,index){
        return BookTitle(book: mybook[index],);
      },
    );
  }
}
 
