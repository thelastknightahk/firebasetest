import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_firebase/model/book.dart';



class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference _collection =
      Firestore.instance.collection("books");

  Future upLoadUserData(String username, String bookName, int rating) async {
    return await _collection.document(uid).setData(
        {'UserName': username, 'BookName': bookName, 'Rating': rating});
  }

  //booklist
  List<Book> _bookSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((e) {
      return Book(
          userName: e.data['UserName'] ?? '',
          bookName: e.data['BookName'] ?? '',
          rating: e.data['Rating'] ?? 0);
    }).toList();
  }

  //get book data
  Stream<List<Book>> get bookData {
    return _collection.snapshots().map(_bookSnapshot);
  }
   
  
 
}
