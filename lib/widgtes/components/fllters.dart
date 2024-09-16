import 'package:flutter/material.dart';
import 'package:uplace/widgtes/themes/colors.dart';

class Filters extends StatefulWidget {
  const Filters({super.key});

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
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
  Widget build(BuildContext context) {
    return ExpansionTile(
        trailing: const Icon(Icons.filter_alt_rounded),
        title: const Text("Filtros"),
        children: [
          Column(
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
        ]);
  }
}
