import 'package:flutter/material.dart';
import 'package:uplace/controller/implementations/itemController.dart';
import 'package:uplace/controller/implementations/sellerController.dart';
import 'package:uplace/models/item.dart';
import 'package:uplace/models/item_category.dart';
import 'package:uplace/models/seller.dart';
import 'package:uplace/widgtes/components/category_menu.dart';
import 'package:uplace/widgtes/components/fllters.dart';
import 'package:uplace/widgtes/components/sellers_item.dart';
import 'package:uplace/widgtes/components/utils/error_alert.dart';
import 'package:uplace/widgtes/routes/routes.dart';
import 'package:uplace/widgtes/themes/colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.title});

  final String title;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ItemController _itemController = ItemController();
  // List<Item>? itemsToPresent = [];
  List<Item>? items = [];
  ItemCategory presentedCategory = ItemCategory.food;
  String query = "";

  @override
  void initState() {
    super.initState();
  }

  Widget searchField() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              labelText: "O que deseja procurar encontrar?",
              labelStyle: TextStyle(fontSize: 18, fontFamily: 'clarissans'),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              fillColor: Colors.white,
            ),
            onChanged: (value) {
              setState(() {
                query = value;
                searchItem();
              });
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueUplace,
        leading: Container(),
        title: Center(
          child: Text(
            widget.title,
            style: const TextStyle(color: AppColors.greenUplace),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 30,
              color: AppColors.greenUplace,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          searchField(),
          const Filters(),
          CategoryMenu(
            onSelectedCategory: (String category) async {
              switch (category) {
                case "Alimentos":
                  presentedCategory = ItemCategory.food;
                  break;
                case "Produtos":
                  presentedCategory = ItemCategory.product;
                  break;
                case "Serviços":
                  presentedCategory = ItemCategory.service;
                  break;
                default:
              }
              setState(() {
                switchCategory();
              });
            },
          ),
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    FutureBuilder<List<Item>?>(
                      future: searchItem(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          items = snapshot.data!;
                          switchCategory();
                          return Column(
                            children: List.generate(
                              items != null ? items!.length : 0,
                              (index) {
                                return GestureDetector(
                                    onTap: () async {
                                      if (items != null) {
                                        navigateToItem(items![index]);
                                      }
                                    },
                                    child: SellersItem(item: items![index]));
                              },
                            ),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          // TODO: Adicionar indicacao de erro
                          print('${snapshot.error}');
                        }
                        return SizedBox();
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<List<Item>?> searchItem() async {
    if (query.isEmpty) {
      return null;
    }

    var response = await _itemController.getSearchedItems(query);
    if (response.isValid) {
      List<Item> items = response.data as List<Item>;
      return items;
    } else {
      return null;
    }
  }

  void navigateToItem(Item item) async {
    print(item);
  }

  switchCategory() {
    items = items?.where((p) => p.category == presentedCategory).toList();
  }
}
