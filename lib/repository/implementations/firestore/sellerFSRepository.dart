import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uplace/models/item.dart';
import 'package:uplace/models/seller.dart';
import 'package:uplace/repository/interfaces/sellerRepositoryInterface.dart';

class SellerFSRepository extends SellerRepositoryInterface {
  late CollectionReference db;
  static final SellerFSRepository _firestoreUserRepository =
      SellerFSRepository._internal();

  @override
  void configure() {
    if (!configured) {
      db = FirebaseFirestore.instance.collection("sellers");
      configured = true;
    }
  }

  SellerFSRepository._internal();
  factory SellerFSRepository() {
    _firestoreUserRepository.configure();
    return _firestoreUserRepository;
  }

  @override
  Future<List<Seller>?> getFoodSellers() async {
    var sellersDocs = await db
        .where("bannedUser", isEqualTo: false)
        .where("sellsFood", isEqualTo: true)
        .get();
    List<Seller> sellers = [];
    sellersDocs.docs.forEach(
      (doc) => sellers.add(
        Seller.FromFirebase(doc.data()! as Map<String, dynamic>, doc.id),
      ),
    );

    return sellers;
  }

  @override
  Future<List<Seller>?> getProductSellers() async {
    var sellersDocs = await db
        .where("bannedUser", isEqualTo: false)
        .where("sellsProduct", isEqualTo: true)
        .get();
    List<Seller> sellers = [];
    sellersDocs.docs.forEach(
      (doc) => sellers.add(
        Seller.FromFirebase(doc.data()! as Map<String, dynamic>, doc.id),
      ),
    );

    return sellers;
  }

  @override
  Future<List<Seller>?> getServiceSellers() async {
    var sellersDocs = await db
        .where("bannedUser", isEqualTo: false)
        .where("sellsService", isEqualTo: true)
        .get();
    List<Seller> sellers = [];
    sellersDocs.docs.forEach(
      (doc) => sellers.add(
        Seller.FromFirebase(doc.data() as Map<String, dynamic>, doc.id),
      ),
    );

    return sellers;
  }

  // @override
  // Future<List<Item>?> getSellerItems(String sellerId) async {
  //   var sellerItemsDocs = await db.doc(sellerId).collection("items").get();
  //   List<Item> sellerItems = [];
  //   sellerItemsDocs.docs.forEach(
  //     (doc) => sellerItems.add(
  //       Item.FromFirebase(doc.data(), doc.id),
  //     ),
  //   );

  //   return sellerItems;
  // }

  // @override
  // Future<List<Item>?> getAllSellerItems() async {
  //   List<Item> sellersItems = [];

  //   var sellersDocs = await db.get();
  //   List<Seller> sellers = [];
  //   sellersDocs.docs.forEach(
  //     (doc) => sellers.add(
  //       Seller.FromFirebase(doc.data()! as Map<String, dynamic>, doc.id),
  //     ),
  //   );

  //   for (Seller seller in sellers) {
  //     var items = await getSellerItems(seller.id);
  //     sellersItems.addAll(items!);
  //   }

  //   return sellersItems;
  // }
}
