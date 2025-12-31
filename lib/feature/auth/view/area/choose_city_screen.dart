import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paschaloliver/feature/auth/view/area/work_area_screen.dart';

import 'select_country_screen.dart'; // for Country model

class SelectCityScreen extends StatefulWidget {
  const SelectCityScreen({super.key});

  @override
  State<SelectCityScreen> createState() => _SelectCityScreenState();
}

class _SelectCityScreenState extends State<SelectCityScreen> {
  Color get _brandGreen => const Color(0xFF27AE60);

  late final Country? _country;
  late List<String> _cities;
  String? _selectedCity;

  @override
  void initState() {
    super.initState();
    _country = Get.arguments is Country ? Get.arguments as Country : null;
    final code = _country?.code ?? 'NG'; // default Nigeria

    _cities = CityData.byCountry[code] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final titleCountry = _country?.name ?? 'country';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ---------------- TOP BAR + PROGRESS ----------------
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18,
                        ),
                        onPressed: () => Get.back(),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: LinearProgressIndicator(
                      value: 0.5, // step 2
                      minHeight: 6,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation<Color>(_brandGreen),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ---------------- TITLE ----------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose city',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: _brandGreen,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'In which city do you want to offer your services\nin $titleCountry?',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            const Divider(height: 1),

            // ---------------- CITY LIST ----------------
            Expanded(
              child: ListView.separated(
                itemCount: _cities.length,
                separatorBuilder: (_, __) =>
                    Divider(height: 1, color: Colors.grey.shade200),
                itemBuilder: (context, index) {
                  final city = _cities[index];
                  final isSelected = _selectedCity == city;

                  return InkWell(
                    onTap: () {
                      setState(() => _selectedCity = city);

                      // TODO: go to next step with both values
                      Get.to(() => const WorkAreaScreen(), arguments: {
                        'country': _country,
                        'city': city,
                      });
                    },
                    child: Container(
                      color:
                      isSelected ? const Color(0xFFF2FFF7) : Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              city,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check_circle,
                              size: 18,
                              color: _brandGreen,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const Divider(height: 1),

            // ---------------- BOTTOM INFO ----------------
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                  children: [
                    const TextSpan(
                      text: "Haven't we reached your area yet?\n",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: 'Request an opening in your area',
                      style: TextStyle(
                        color: _brandGreen,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // TODO: open contact / request form
                        },
                    ),
                    const TextSpan(
                      text:
                      ' and we will do our best to reach you as soon as possible.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// -------------------- CITY DATA --------------------

class CityData {
  static final Map<String, List<String>> byCountry = {
    // ---------- Nigeria ----------
    'NG': [
      'Ilorin',
      'Abuja',
      'Ogbomosho',
      'Ikorodu',
      'Maiduguri',
      'Bauchi',
      'Akure',
      'Abeokuta',
      'Sokoto',
      'Owerri',
      'Calabar',
      'Lagos',
      'Kano',
      'Ibadan',
    ],

    // ---------- Bangladesh ----------
    'BD': [
      'Dhaka',
      'Chattogram',
      'Sylhet',
      'Rajshahi',
      'Khulna',
      'Barishal',
      'Rangpur',
      'Mymensingh',
      'Gazipur',
      'Narayanganj',
    ],

    // ---------- United States ----------
    'US': [
      'New York',
      'Los Angeles',
      'Chicago',
      'Houston',
      'San Francisco',
      'Miami',
      'Seattle',
      'Boston',
    ],

    // add more country -> city lists as needed
  };
}
