import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDropDownButton extends StatelessWidget {
  final List<String>? items;
  final String? hintText;
  final double? width;
  final bool isListOfString;
  final String? value;
  final bool showDropDownMenu;
  final Color borderColor;
  final TextEditingController? dropDownMenuController;
  final void Function(dynamic)? onChnaged;
  final String? Function(dynamic)? validator;
  final void Function()? onTap;
  final List<DropdownMenuItem<dynamic>>? dropDownItemList;
  final List<DropdownMenuEntry<dynamic>> dropDownMenuEntryList;
  final Color fillColor;
  final void Function(String?)? onSelected;

  const CustomDropDownButton(
      {super.key,
      this.hintText,
      this.items,
      this.width,
      this.dropDownMenuController,
      this.showDropDownMenu = false,
      this.value,
      this.dropDownItemList,
      this.validator,
      this.onTap,
      this.isListOfString = true,
      this.onChnaged,
      this.dropDownMenuEntryList = const [
        DropdownMenuEntry(
          value: "h",
          label: "g",
        )
      ],
      this.onSelected,
      this.fillColor = const Color(0xffF3F3F3),
      this.borderColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: showDropDownMenu
          ? DropdownMenu(
              hintText: hintText,
              controller: dropDownMenuController,
              onSelected: onSelected,
              textStyle: const TextStyle(fontSize: 26),
              trailingIcon: Icon(
                Icons.expand_more,
                size: 30,
                color: context.iconColor,
              ),
              enableSearch: false,
              width: width ?? 150,
              menuStyle: MenuStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              inputDecorationTheme: InputDecorationTheme(
                hintStyle: TextStyle(color: Colors.grey.shade200),
                filled: true,
                fillColor: Colors.grey.shade200,
                focusColor: Colors.grey.shade200,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(6),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(6),
                ),
                isDense: true,
                isCollapsed: false,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              label: Text(
                "$hintText",
                style: const TextStyle(fontSize: 16),
              ),

              dropdownMenuEntries: items!.map((String value) {
                return DropdownMenuEntry<String>(
                  value: value,
                  label: value,
                );
              }).toList(),

              // value: value,
              // dropdownColor: AppColors.white,
              // isDense: true,
              // isExpanded: true,
              // icon: Icon(
              //   Icons.expand_more,
              //   color: context.iconColor,
              //   size: Sizes.WIDTH_30,
              // ),
              // hint: Text(
              //   hintText!,
              //   style:
              //       context.bodyMedium.copyWith(fontWeight: FontWeight.w600),
              // ),
              // onTap: onTap,
              // items: items!.map((String value) {
              //   return DropdownMenuItem<String>(
              //     value: value,
              //     child: Text(
              //       value,
              //       style: context.bodyMedium
              //           .copyWith(fontWeight: FontWeight.w600),
              //     ),
              //   );
              // }).toList(),
              //onChanged: onChnaged,
            )
          : DropdownButtonFormField(
              validator: validator,
              decoration: InputDecoration(
                filled: true,
                contentPadding:
                    const EdgeInsets.only(top: 6, left: 10, right: 6),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                  borderRadius: BorderRadius.circular(6),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                  borderRadius: BorderRadius.circular(6),
                ),
                fillColor: fillColor,
                labelText: "$hintText",
                labelStyle: const TextStyle(fontSize: 14, color: Colors.black),
              ),
              value: value,
              isDense: true,
              elevation: 0,
              iconDisabledColor: context.iconColor,
              iconEnabledColor: context.iconColor,
              isExpanded: true,
              icon: const Icon(Icons.expand_more),
              items: isListOfString
                  ? items!.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList()
                  : dropDownItemList,
              autofocus: false,
              alignment: AlignmentDirectional.center,
              focusColor: Colors.white,
              dropdownColor: Colors.white,
              onChanged: onChnaged),
    );
  }
}
