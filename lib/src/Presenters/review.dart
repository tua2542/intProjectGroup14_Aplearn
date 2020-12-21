import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewProvider {
  final CollectionReference commentCollection = Firestore.instance
      .collection('courses')
      .document('thai')
      .collection('reviews');
  Future updateCommentData(String message) async {
    return await commentCollection.document().setData({
      'message': message,
    });
  }
}
