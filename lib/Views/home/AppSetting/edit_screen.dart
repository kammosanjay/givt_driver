import 'package:flutter/material.dart';
import 'package:givt_driver_app/Utils/appColor.dart';

import 'package:givt_driver_app/Views/home/AppSetting/profile_provider.dart';
import 'package:givt_driver_app/Views/home/AppSetting/profilemodal.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController mobileCtrl = TextEditingController();
  final TextEditingController dobCtrl = TextEditingController();
  final TextEditingController genderCtrl = TextEditingController();

  String? genderValue;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      loadInfo();
    });
  }

  void loadInfo() async {
    await context.read<ProfileProvider>().profileInformation();

    final proInfo = context.read<ProfileProvider>().profileModal;

    if (!mounted) return;

    if (proInfo != null) {
      setState(() {
        nameCtrl.text = proInfo.name ?? "";
        emailCtrl.text = proInfo.email ?? "";
        dobCtrl.text = proInfo.dob ?? "";
        genderValue = proInfo.gender;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkEnabled = Theme.brightnessOf(context) == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor:Colors.grey.shade100,
        title: Text(
          "Edit Profile",
          style: TextStyle(
            fontFamily: "san-serif",
            fontSize: 20,
            color: isDarkEnabled ? MyColors.bodyText : MyColors.bodyText,
            fontWeight: FontWeight.w600,
          ),
        ),

        leading: Image.asset("assets/images/couponlogo.png"),

        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Consumer<ProfileProvider>(
            builder: (context, profilePro, child) {
              if (profilePro.isLoading!) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _title("Name"),
                          _inputField(
                            controller: nameCtrl,
                            hint: "Enter your name",
                            icon: Icons.person,
                          ),

                          _title("Email"),
                          _inputField(
                            controller: emailCtrl,
                            hint: "Enter your email",
                            icon: Icons.email,
                            keyboard: TextInputType.emailAddress,
                          ),

                          _title("Gender"),
                          DropdownButtonFormField<String>(
                            value: genderValue,
                            decoration: _inputDecoration(icon: Icons.people),
                            hint: Text("Select Gender"),
                            items: ["Male", "Female"]
                                .map(
                                  (g) => DropdownMenuItem(
                                    value: g,
                                    child: Text(g),
                                  ),
                                )
                                .toList(),
                            onChanged: (val) =>
                                setState(() => genderValue = val),
                          ),

                          _title("Date of Birth"),
                          TextFormField(
                            controller: dobCtrl,
                            readOnly: true,
                            onTap: () async {
                              final select = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1950),
                                lastDate: DateTime.now(),
                                initialDate: DateTime(2000),
                              );
                              if (select != null) {
                                dobCtrl.text =
                                    "${select.day}-${select.month}-${select.year}";
                              }
                            },
                            decoration: _inputDecoration(
                              icon: Icons.calendar_month,
                            ).copyWith(hintText: "Select DOB"),
                          ),

                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Call your update API here

                                  String convertDob(String dob) {
                                    DateTime date = DateTime.parse(dob);
                                    return DateFormat(
                                      'dd-MM-yyyy',
                                    ).format(date);
                                  }

                                  final newDate = convertDob(dobCtrl.text);

                                  profilePro.editProfile(
                                    ProfileModal(
                                      name: nameCtrl.text,
                                      email: emailCtrl.text,
                                      gender: genderValue,
                                      dob: newDate,
                                    ),
                                    context,
                                  );
                                }
                              },
                              child: Text(
                                "Save Changes",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  // Reusable card container
  Widget _buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: MyColors.backgroundColor,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: child,
    );
  }

  // Section title
  Widget _title(String text) {
    final isDarkEnabled = Theme.brightnessOf(context) == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(top: 14, bottom: 6),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: "san-serif",
          fontSize: 12,
          color: isDarkEnabled ? MyColors.bodyText : MyColors.bodyText,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Text input field
  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboard = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,

      decoration: _inputDecoration(icon: icon).copyWith(hintText: hint),
      validator: (v) {
        if (v == null || v.isEmpty) return "This field can’t be empty";
        return null;
      },
    );
  }

  // Common input decoration
  InputDecoration _inputDecoration({required IconData icon}) {
    final isDarkEnabled = Theme.brightnessOf(context) == Brightness.dark;
    return InputDecoration(
      hintStyle: TextStyle(
        fontFamily: "san-serif",
        fontSize: 12,
        color: isDarkEnabled ? MyColors.bodyText : MyColors.bodyText,
        fontWeight: FontWeight.w600,
      ),
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.07),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
