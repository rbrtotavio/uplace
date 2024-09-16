import 'package:uplace/models/item.dart';
import 'package:uplace/repository/interfaces/baseRepository.dart';

abstract class ItemRepositoryInterface extends BaseRepository {
  Future<List<Item>?> getSellerItems(String sellerId);
  Future<List<Item>?> getAllItems();
  void insertItem(Item item);
  Future<List<Item>?> getSearchedItems(String query);
}
