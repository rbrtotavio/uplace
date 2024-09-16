import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uplace/models/item.dart';
import 'package:uplace/models/item_category.dart';
import 'package:uplace/repository/interfaces/itemRepositoryInterface.dart';

class ItemFSRepository extends ItemRepositoryInterface {
  late CollectionReference db;
  static final ItemFSRepository _firestoreUserRepository =
      ItemFSRepository._internal();

  @override
  void configure() {
    if (!configured) {
      db = FirebaseFirestore.instance.collection("items");
      configured = true;
    }
  }

  ItemFSRepository._internal();
  factory ItemFSRepository() {
    _firestoreUserRepository.configure();
    return _firestoreUserRepository;
  }

  @override
  Future<List<Item>?> getAllItems() async {
    var sellerItemsDocs = await db.get();
    List<Item> items = [];
    for (var doc in sellerItemsDocs.docs) {
      items.add(
        Item.FromFirebase(
          doc.data() as Map<String, dynamic>,
          doc.id,
        ),
      );
    }

    return items;
  }

  @override
  Future<List<Item>?> getSellerItems(String sellerId) async {
    var sellerItemsDocs = await db
        .where(
          "sellerId",
          isEqualTo: sellerId,
        )
        .get();
    List<Item> sellerItems = [];
    for (var doc in sellerItemsDocs.docs) {
      sellerItems.add(
        Item.FromFirebase(
          doc.data() as Map<String, dynamic>,
          doc.id,
        ),
      );
    }

    return sellerItems;
  }

  @override
  void insertItem(Item item) {
    db.add(item.toFirestore());
  }
}
