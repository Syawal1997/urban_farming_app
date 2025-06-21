import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:urban_farming_app/models/product.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadProductImage(String filePath) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = _storage.ref().child('product_images/$fileName');
      UploadTask uploadTask = ref.putFile(filePath as dynamic);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw e;
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      await _firestore.collection('products').add(product.toMap());
    } catch (e) {
      throw e;
    }
  }

  Future<List<Product>> getProducts() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('products')
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs
          .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      throw e;
    }
  }

  Future<Product> getProductById(String id) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('products').doc(id).get();
      return Product.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    } catch (e) {
      throw e;
    }
  }

  Future<List<Product>> getProductsBySeller(String sellerId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('products')
          .where('sellerId', isEqualTo: sellerId)
          .get();
      return snapshot.docs
          .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateProductStock(String productId, int newStock) async {
    try {
      await _firestore
          .collection('products')
          .doc(productId)
          .update({'stock': newStock});
    } catch (e) {
      throw e;
    }
  }
}