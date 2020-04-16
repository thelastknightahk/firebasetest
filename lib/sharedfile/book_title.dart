import 'package:flutter/material.dart';
import 'package:hello_firebase/model/book.dart';

class BookTitle extends StatelessWidget {
  final Book book;

  const BookTitle({Key key, this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown,

          ),
          title: Text(book.userName),
          subtitle: Text('Takes ${book.bookName} book '),
        ),
      ),
    );
  }
}