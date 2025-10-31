import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CategoryRepository {
  final categoryRef = FirebaseFirestore.instance.collection('Categories');
  final storageRef = FirebaseStorage.instance.ref('Categories');
  
}
