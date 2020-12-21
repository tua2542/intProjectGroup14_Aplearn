import 'package:cloud_firestore/cloud_firestore.dart';

class CommentProvider {


  final CollectionReference commentCollection =
      Firestore.instance.collection('comments');
  Future updateCommentData(String message) async {
    return await commentCollection.document().setData({
      'message' : message,
    });
  }
}
