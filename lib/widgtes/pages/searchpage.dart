import 'package:flutter/material.dart';
import 'package:uplace/controller/implementations/itemController.dart';
import 'package:uplace/controller/implementations/sellerController.dart';
import 'package:uplace/models/seller.dart';
import 'package:uplace/widgtes/themes/colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.title});

  final String title;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ItemController _itemController = ItemController();

  final List<String> characteristics = [
    "Alimentos",
    "Eletrônicos",
    "Vestuário",
    "Serviços",
    "Móveis",
    "Beleza",
    "Esportes",
    "Automóveis",
    "Brinquedos",
  ];

  final List<String> locations = ["CEAGRI", "CEGOE", "R.U."];

  final List<bool> _isSelectedCharacteristics = List.filled(9, false);
  final List<bool> _isSelectedLocations = List.filled(3, false);

  double _proximity = 5.0;

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
              labelText: "Nome da loja",
              labelStyle: TextStyle(fontSize: 18, fontFamily: 'clarissans'),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              fillColor: Colors.white,
            ),
            onChanged: (value) {
              setState(() {
                searchItem(value);
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: searchField(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Categorias",
                    style: TextStyle(
                      fontFamily: 'clarissans',
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8.0,
                  children: List.generate(characteristics.length, (index) {
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isSelectedCharacteristics[index] =
                              !_isSelectedCharacteristics[index];
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isSelectedCharacteristics[index]
                            ? AppColors.greenUplace
                            : Colors.grey[300],
                        foregroundColor: _isSelectedCharacteristics[index]
                            ? Colors.white
                            : Colors.black,
                      ),
                      child: Text(characteristics[index]),
                    );
                  }),
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Proximidade",
                    style: TextStyle(
                      fontFamily: 'clarissans',
                      fontSize: 24,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: _proximity,
                        min: 1.0,
                        max: 10.0,
                        divisions: 9,
                        label: "${_proximity.toInt()} km",
                        onChanged: (value) {
                          setState(() {
                            _proximity = value;
                          });
                        },
                      ),
                    ),
                    Text(
                      "${_proximity.toInt()} km",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Local",
                    style: TextStyle(
                      fontFamily: 'clarissans',
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8.0,
                  children: List.generate(locations.length, (index) {
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isSelectedLocations[index] =
                              !_isSelectedLocations[index];
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isSelectedLocations[index]
                            ? AppColors.greenUplace
                            : Colors.grey[300],
                        foregroundColor: _isSelectedLocations[index]
                            ? Colors.white
                            : Colors.black,
                      ),
                      child: Text(locations[index]),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void searchItem(query) async {
    var items = await _itemController.getSearchedItems(query);
    print(items![0]);
    print(items != null ? items.length : 0);
  }

  Future<List<Seller>?> getFoodsResults() async {}

  Future<List<Seller>?> getProductResults() async {}

  Future<List<Seller>?> getServiceResults() async {}
}
