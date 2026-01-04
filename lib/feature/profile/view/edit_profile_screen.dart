import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _aboutCtrl = TextEditingController();
  static const int _max = 500;

  @override
  void dispose() {
    _aboutCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: _C.bg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: _C.green),
        ),
        title: const Text(
          "Edit profile",
          style: TextStyle(
            color: _C.text,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar
                    Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 110,
                            height: 110,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFE7E1DE),
                            ),
                            child: ClipOval(
                              child: Image.network(
                                "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=400",
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => const Center(
                                  child: Icon(Icons.person, size: 48, color: Color(0xFF8A8A8A)),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: -2,
                            bottom: 6,
                            child: Material(
                              color: _C.green,
                              shape: const CircleBorder(),
                              child: InkWell(
                                customBorder: const CircleBorder(),
                                onTap: () {
                                  // TODO: open image picker
                                },
                                child: const SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Icon(Icons.camera_alt_rounded, color: Colors.white, size: 18),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      "About me",
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: _C.text,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // About box
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _C.border),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0F000000),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
                      child: Column(
                        children: [
                          TextField(
                            controller: _aboutCtrl,
                            maxLines: 6,
                            maxLength: _max,
                            buildCounter: (_, {required currentLength, maxLength, required isFocused}) => const SizedBox(),
                            style: const TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: _C.text,
                              height: 1.3,
                            ),
                            decoration: const InputDecoration(
                              hintText: "Write a description about you..",
                              hintStyle: TextStyle(
                                color: _C.subText,
                                fontSize: 12.5,
                                fontWeight: FontWeight.w500,
                              ),
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            onChanged: (_) => setState(() {}),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Spacer(),
                              Text(
                                "${_aboutCtrl.text.length}/$_max",
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: _C.subText,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Save button
            Container(
              padding: EdgeInsets.fromLTRB(18, 12, 18, 12 + bottom),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: _C.divider, width: 1)),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _C.greenSoft,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    // TODO: save
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _C {
  static const bg = Colors.white;

  static const green = Color(0xFF27AE60);
  static const greenSoft = Color(0xFF3DA86A);

  static const text = Color(0xFF111111);
  static const subText = Color(0xFF9A9A9A);

  static const border = Color(0xFFE8E8E8);
  static const divider = Color(0xFFEDEDED);
}
