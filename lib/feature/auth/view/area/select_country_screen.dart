import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'choose_city_screen.dart';


class SelectCountryScreen extends StatefulWidget {
  const SelectCountryScreen({super.key});

  @override
  State<SelectCountryScreen> createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  Color get _brandGreen => const Color(0xFF27AE60);

  late List<Country> _countries;
  late List<Country> _filtered;
  Country? _selected;
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _countries = CountryData.allCountries;
    _filtered = _countries;
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _filtered = _countries
          .where(
            (c) => c.name.toLowerCase().contains(query.trim().toLowerCase()),
      )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // -------------------- TOP BAR + PROGRESS --------------------
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
              child: Column(
                children: [
                  // back arrow row
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
                      value: 0.25, // step 1
                      minHeight: 6,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation<Color>(_brandGreen),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // -------------------- TITLE --------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select country',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: _brandGreen,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'In which country do you want to offer your services?',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // -------------------- SEARCH FIELD --------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextField(
                controller: _searchCtrl,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search country',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade500,
                  ),
                  prefixIcon: const Icon(Icons.search, size: 20),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            const Divider(height: 1),

            // -------------------- COUNTRY LIST --------------------
            Expanded(
              child: ListView.separated(
                itemCount: _filtered.length,
                separatorBuilder: (_, __) =>
                    Divider(height: 1, color: Colors.grey.shade200),
                itemBuilder: (context, index) {
                  final country = _filtered[index];
                  final isSelected = _selected?.code == country.code;

                  return InkWell(
                    onTap: () {
                      setState(() => _selected = country);

                      // ✅ Go to SelectCityScreen with this country
                      Get.to(
                            () => const SelectCityScreen(),
                        arguments: country,
                      );
                    },
                    child: Container(
                      color: isSelected
                          ? const Color(0xFFF2FFF7)
                          : Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      child: Row(
                        children: [
                          Text(
                            country.flagEmoji,
                            style: const TextStyle(fontSize: 22),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              country.name,
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

            // -------------------- BOTTOM INFO --------------------
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
                          // TODO: open request form / support page
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

/// -------------------- COUNTRY MODEL --------------------

class Country {
  final String name;
  final String code; // ISO 3166-1 alpha-2

  Country({required this.name, required this.code});

  // Compute emoji flag from ISO code
  String get flagEmoji {
    if (code.length != 2) return '';
    final int base = 0x1F1E6 - 'A'.codeUnitAt(0);
    return String.fromCharCodes([
      base + code.codeUnitAt(0),
      base + code.codeUnitAt(1),
    ]);
  }
}

/// -------------------- COUNTRY DATA --------------------

class CountryData {
  static final List<Country> allCountries = [
    Country(name: 'Nigeria', code: 'NG'),
    Country(name: 'United States', code: 'US'),
    Country(name: 'United Kingdom', code: 'GB'),
    Country(name: 'Canada', code: 'CA'),
    Country(name: 'Germany', code: 'DE'),
    Country(name: 'France', code: 'FR'),
    Country(name: 'India', code: 'IN'),
    Country(name: 'Brazil', code: 'BR'),
    Country(name: 'South Africa', code: 'ZA'),
    Country(name: 'Kenya', code: 'KE'),
    Country(name: 'Ghana', code: 'GH'),
    Country(name: 'Australia', code: 'AU'),
    Country(name: 'Italy', code: 'IT'),
    Country(name: 'Spain', code: 'ES'),
    Country(name: 'Netherlands', code: 'NL'),
    Country(name: 'Ireland', code: 'IE'),
    Country(name: 'United Arab Emirates', code: 'AE'),
    Country(name: 'Saudi Arabia', code: 'SA'),
    Country(name: 'Turkey', code: 'TR'),
    Country(name: 'China', code: 'CN'),
    Country(name: 'Japan', code: 'JP'),
    Country(name: 'South Korea', code: 'KR'),
    Country(name: 'Mexico', code: 'MX'),
    Country(name: 'Argentina', code: 'AR'),
    Country(name: 'Chile', code: 'CL'),
    Country(name: 'Egypt', code: 'EG'),
    Country(name: 'Morocco', code: 'MA'),
    Country(name: 'Bangladesh', code: 'BD'),
    Country(name: 'Pakistan', code: 'PK'),
    Country(name: 'Sri Lanka', code: 'LK'),
    Country(name: 'Singapore', code: 'SG'),
    Country(name: 'Malaysia', code: 'MY'),
    Country(name: 'Indonesia', code: 'ID'),
    Country(name: 'Philippines', code: 'PH'),
    Country(name: 'Vietnam', code: 'VN'),
    Country(name: 'Thailand', code: 'TH'),
    Country(name: 'Russia', code: 'RU'),
    Country(name: 'Ukraine', code: 'UA'),
    Country(name: 'Poland', code: 'PL'),
    Country(name: 'Sweden', code: 'SE'),
    Country(name: 'Norway', code: 'NO'),
    Country(name: 'Denmark', code: 'DK'),
    Country(name: 'Finland', code: 'FI'),
    Country(name: 'Switzerland', code: 'CH'),
    Country(name: 'Portugal', code: 'PT'),
    Country(name: 'Greece', code: 'GR'),
    Country(name: 'New Zealand', code: 'NZ'),
    // Add more if needed
  ];
}
