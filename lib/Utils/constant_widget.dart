import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:givt_driver_app/Utils/appColor.dart';

class CustomWidgets {
  ///TextFeild Widget

  static Widget customTextFeild({
    required BuildContext context, // Pass BuildContext as a parameter
    String? name,
    String? hint,
    double? elevation,
    TextEditingController? controller,
    FocusNode? focusNode,
    Widget? icon,
    double? width,
    AutovalidateMode? autovalidateMode,
    int? maxLines,
    int? maxLength,
    Color? headingcolor,
    Color? hintColor,
    Color? fillcolor,
    double? height,
    TextInputType? keyboardtype,
    Function? onTap,
    Function? onChanges,
    double? borderRad,
    var validate,
    bool isObstructed = false,
    Color? iconColor,
    Widget? suffIcons,
    TextInputAction? action,
    bool isReadyOnly = false,
    String label = "",
    var fontSize,
    FontWeight? fontwgt,
    double? hintfontSize,
    String? fontfamily,

    FontWeight? hintfontWeight,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // label.isEmpty
        //     ? const SizedBox.shrink() // returns nothing
        //     : Text(
        //         label,
        //         style: GoogleFonts.inter(
        //           color: headingcolor ?? Colors.white,
        //           fontSize: fontSize ?? 16,
        //           fontWeight: fontwgt ?? FontWeight.w600,
        //         ),
        //       ),
        // SizedBox(height: label.isEmpty ? 0 : 10),
        TextFormField(
          buildCounter:
              (
                context, {
                required currentLength,
                required isFocused,
                required maxLength,
              }) {
                return null;
              },

          focusNode: focusNode,
          readOnly: isReadyOnly,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: keyboardtype,
          validator: validate,

          maxLength: maxLength,
          maxLines: maxLines ?? 1,
          controller: controller ?? TextEditingController(),
          textAlignVertical: TextAlignVertical.center,
          textInputAction: action,

          onTap: () {
            if (onTap != null) {
              onTap();
            }
          },
          onChanged: (value) {
            if (onChanges != null) {
              onChanges(value); // Call the function with the text value
            }
          },
          obscureText: isObstructed,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: height ?? 19,

              horizontal: width ?? 12,
            ),
            suffixIcon: suffIcons,
            // labelText: name,
            label: Text(
              name!,
              style: TextStyle(
                fontFamily: 'san-serif',
                color: headingcolor ?? const Color.fromARGB(255, 182, 34, 34),
                fontSize: fontSize ?? 12,
                fontWeight: fontwgt ?? FontWeight.w600,
              ),
            ),
            fillColor: isReadyOnly
                ? Colors.grey.shade400
                : fillcolor ?? Colors.white,
            filled: true,

            prefixIcon: icon,
            prefixIconColor: iconColor,

            hintText: hint,
            hintStyle: GoogleFonts.inter(
              color: hintColor ?? Colors.white,
              fontSize: hintfontSize ?? 12,
              fontWeight: hintfontWeight ?? FontWeight.w600,
            ),

            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300, width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(borderRad ?? 10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade500, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(borderRad ?? 10)),
            ),
            // errorBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: Colors.red, width: 1),
            //   borderRadius: BorderRadius.all(Radius.circular(borderRad ?? 10)),
            // ),
          ),
          errorBuilder: (context, errorText) => Text(
            errorText,
            style: TextStyle(
              fontFamily: 'san-serif',
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  // custom dropdown widget
  static Widget customDropdownField<T>({
    required BuildContext context,
    required List<T> items,
    required T? selectedItem,
    required ValueChanged<T?> onChanged,

    String? hint,
    Color? color,
    Widget? icon,
    Color? iconColor,
    Widget? suffixIcon,
    double? width,
    FocusNode? focusNode,
    AutovalidateMode? autovalidateMode,
    bool readOnly = false,
    var validate,
    String? label,
    double fontSize = 14,
    var fontwgt,
    double? height,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Card(
          color: readOnly ? Colors.grey.shade400 : Colors.white,
          margin: EdgeInsets.zero,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          elevation: 0,

          child: DropdownButtonFormField<T>(
            dropdownColor: Colors.white,
            style: TextStyle(fontFamily: 'san-serif', color: Colors.black),
            value: selectedItem,
            isExpanded: true,
            focusNode: focusNode,
            hint: Text(
              hint!,
              style: TextStyle(
                fontFamily: 'san-serif',
                color: Colors.grey,
                fontSize: fontSize,
              ),
            ),
            selectedItemBuilder: (BuildContext context) {
              return items.map<Widget>((T item) {
                return Text("$item", style: TextStyle(color: Colors.black));
              }).toList();
            },
            validator: validate,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            icon: suffixIcon,

            decoration: InputDecoration(
              prefixIcon: icon,
              labelText: label,
              labelStyle: TextStyle(
                fontFamily: 'san-serif',
                color: MyColors.appSteelGrey,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              prefixIconColor: iconColor,
              isDense: true,
              constraints: BoxConstraints(
                maxHeight: height ?? 50,

                maxWidth: width ?? MediaQuery.of(context).size.width,
              ),

              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300, width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade500, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            items: items.map((T value) {
              return DropdownMenuItem<T>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
            onChanged: readOnly ? null : onChanged,
          ),
        ),
      ],
    );
  }

  ///Button Widget

  static Widget customButton({
    required BuildContext context,
    dynamic buttonName,
    VoidCallback? onPressed,
    bool isLoading = false, // 👈 add this
    double? width,
    double? height,
    Color? btnColor,
    Color? fontColor,
    double? radius,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed, // 👈 disable when loading
      style: ElevatedButton.styleFrom(
        fixedSize: Size(
          width ?? MediaQuery.of(context).size.width,
          height ?? 50,
        ),
        backgroundColor: btnColor ?? Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 10),
        ),
      ),
      child: isLoading
          ? SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  fontColor ?? Colors.white,
                ),
              ),
            )
          : FittedBox(
              child: Text(
                buttonName ?? 'Button',
                style: TextStyle(
                  fontFamily: 'san-serif',
                  fontSize: fontSize ?? 12,
                  fontWeight: fontWeight ?? FontWeight.w600,
                  color: fontColor ?? Colors.white,
                ),
              ),
            ),
    );
  }

  ///
  ///
  ///

  static myCustomTextWidget(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        foreground: Paint()
          ..shader = LinearGradient(
            colors: [
              MyColors.primaryColor,
              MyColors.textColor,
            ], // Use two different colors for the gradient
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
      ),
    );
  }

  static final gap_1 = const SizedBox(height: 1);
  static final gap_10 = const SizedBox(height: 10);
  static final gap_15 = const SizedBox(height: 15);
  static final gap_20 = const SizedBox(height: 20);
  static final gap_25 = const SizedBox(height: 25);
  static final gap_30 = const SizedBox(height: 30);
  static final gap_35 = const SizedBox(height: 35);
  static final gap_40 = const SizedBox(height: 40);
  static final gap_45 = const SizedBox(height: 45);
}
