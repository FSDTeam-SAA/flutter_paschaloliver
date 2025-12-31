import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../work/work_schedule_screen.dart';

class WorkAreaScreen extends StatefulWidget {
  const WorkAreaScreen({super.key});

  @override
  State<WorkAreaScreen> createState() => _WorkAreaScreenState();
}

enum _WorkAreaViewMode { map, list }

class _WorkAreaScreenState extends State<WorkAreaScreen> {
  Color get _brandGreen => const Color(0xFF27AE60);

  _WorkAreaViewMode _viewMode = _WorkAreaViewMode.map;

  // sample work areas
  final List<WorkArea> _areas = const [
    WorkArea(id: 'ajeromi', name: 'Ajeromi-Ifelodun'),
    WorkArea(id: 'alimosho', name: 'Alimosho'),
    WorkArea(id: 'kosofe', name: 'Kosofe'),
    WorkArea(id: 'mushin', name: 'Mushin'),
    WorkArea(id: 'oshodi', name: 'Oshodi-Isola'),
    WorkArea(id: 'ojo', name: 'Ojo'),
    WorkArea(id: 'ikorodu', name: 'Ikorodu'),
    WorkArea(id: 'surulere', name: 'Surulere'),
  ];

  final Set<String> _selectedIds = {}; // store selected area ids
  bool _hasChanges = false;

  bool get _hasSelection => _selectedIds.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTopBar(),
              const SizedBox(height: 12),
              _buildTitle(),
              const SizedBox(height: 12),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _viewMode == _WorkAreaViewMode.map
                      ? _buildMapView()
                      : _buildListView(),
                ),
              ),
              _buildViewToggle(),
              const SizedBox(height: 12),
              _buildContinueButton(),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- TOP BAR + PROGRESS ----------------

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                onPressed: _handleBackPressed,
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: 0.6, // step in the flow
              minHeight: 6,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(_brandGreen),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- TITLE ----------------

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Work areas',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: _brandGreen,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Select the areas you can travel to in order to offer your '
                'services. Remember that you cannot charge an extra fee for travel.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- MAP VIEW ----------------

  Widget _buildMapView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Stack(
        children: [
          // placeholder map – replace with GoogleMap or similar
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Image.asset(
                'assets/images/sample_map.png', // TODO: your map asset
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (_selectedIds.isNotEmpty) ...[
            _mapPin(const Offset(0.25, 0.3)),
            _mapPin(const Offset(0.5, 0.6)),
            _mapPin(const Offset(0.7, 0.35)),
          ],
        ],
      ),
    );
  }

  Widget _mapPin(Offset fractionalPosition) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dx = constraints.maxWidth * fractionalPosition.dx;
        final dy = constraints.maxHeight * fractionalPosition.dy;
        return Positioned(
          left: dx - 16,
          top: dy - 32,
          child: const Icon(
            Icons.location_on,
            size: 32,
            color: Colors.redAccent,
          ),
        );
      },
    );
  }

  // ---------------- LIST VIEW ----------------

  Widget _buildListView() {
    return Column(
      children: [
        const Divider(height: 1),
        Expanded(
          child: ListView.separated(
            itemCount: _areas.length,
            separatorBuilder: (_, __) =>
                Divider(height: 1, color: Colors.grey.shade200),
            itemBuilder: (context, index) {
              final area = _areas[index];
              final isSelected = _selectedIds.contains(area.id);

              return InkWell(
                onTap: () => _toggleArea(area.id),
                child: Container(
                  color:
                  isSelected ? const Color(0xFFF2FFF7) : Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  child: Row(
                    children: [
                      _buildCheckBox(isSelected),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          area.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCheckBox(bool isSelected) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isSelected ? _brandGreen : Colors.grey.shade400,
          width: 1.5,
        ),
        color: isSelected ? _brandGreen : Colors.white,
      ),
      child: isSelected
          ? const Icon(Icons.check, size: 16, color: Colors.white)
          : null,
    );
  }

  void _toggleArea(String id) {
    setState(() {
      _hasChanges = true;
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
  }

  // ---------------- VIEW TOGGLE (MAP / LIST) ----------------

  Widget _buildViewToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            Expanded(
              child: _buildToggleButton(
                label: 'Map',
                isActive: _viewMode == _WorkAreaViewMode.map,
                onTap: () {
                  setState(() => _viewMode = _WorkAreaViewMode.map);
                },
              ),
            ),
            Expanded(
              child: _buildToggleButton(
                label: 'List',
                isActive: _viewMode == _WorkAreaViewMode.list,
                onTap: () {
                  setState(() => _viewMode = _WorkAreaViewMode.list);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton({
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.black87 : Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- CONTINUE BUTTON + FEW AREAS SHEET ----------------

  Widget _buildContinueButton() {
    final enabled = _hasSelection;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
            enabled ? _brandGreen : Colors.grey.shade300,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: enabled ? _handleContinue : null,
          child: const Text(
            'Continue',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _handleContinue() {
    if (_selectedIds.isEmpty) return;

    if (_selectedIds.length == 1) {
      // show "few selected areas"
      _showFewAreasSheet();
    } else {
      _goToSchedule();
    }
  }

  void _goToSchedule() {
    _hasChanges = false;
    Get.to(
          () => const WorkScheduleScreen(),
      arguments: _selectedIds.toList(), // pass ids if needed
    );
  }

  void _showFewAreasSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        return Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Few selected areas',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, size: 18),
                  )
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'You have selected very few available work areas. '
                    'Remember that your profile will only be visible to clients '
                    'searching in the areas you have marked as available.',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _brandGreen,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    _goToSchedule();
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  // ---------------- LEAVE WITHOUT SAVING ----------------

  void _handleBackPressed() async {
    if (!await _onWillPop()) return;
    Get.back();
  }

  Future<bool> _onWillPop() async {
    if (!_hasChanges) return true;

    final result = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        return Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Do you want to leave without saving?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context, false),
                    icon: const Icon(Icons.close, size: 18),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'If you leave without saving, you will lose all the '
                    'information completed in this section.',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: _brandGreen),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () =>
                          Navigator.pop<bool>(context, true),
                      child: Text(
                        'Leave anyway',
                        style: TextStyle(
                          color: _brandGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _brandGreen,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () =>
                          Navigator.pop<bool>(context, false),
                      child: const Text(
                        'Stay',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );

    return result ?? false;
  }
}

// ---------------- MODEL ----------------

class WorkArea {
  final String id;
  final String name;

  const WorkArea({
    required this.id,
    required this.name,
  });
}
