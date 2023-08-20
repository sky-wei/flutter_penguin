/*
 * Copyright (c) 2023 The sky Authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_penguin/data/item/option_item.dart';
import 'package:flutter_penguin/theme/color.dart';
import 'package:flutter_svg/svg.dart';

class SimpleDropdownButton<T> extends StatelessWidget {

  final String? hint;
  final OptionItem<T> value;
  final List<OptionItem<T>> dropdownItems;
  final ValueChanged<OptionItem<T>?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight, dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset offset;

  const SimpleDropdownButton({
    this.hint,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.selectedItemBuilder,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset = const Offset(0, 0),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<OptionItem<T>>(
        //To avoid long text overflowing.
        isExpanded: true,
        hint: hint != null ? Container(
          alignment: hintAlignment,
          child: Text(
            hint!,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: 15.sp,
              color: Theme.of(context).hintColor,
            ),
          ),
        ) : null,
        value: value,
        items: _buildOptionMenuItem(dropdownItems),
        onChanged: onChanged,
        selectedItemBuilder: selectedItemBuilder,
        buttonStyleData: ButtonStyleData(
          height: buttonHeight ?? 32.h,
          width: buttonWidth ?? 140.w,
          padding: buttonPadding ?? REdgeInsets.only(left: 15, right: 10),
          overlayColor: MaterialStateProperty.all(XColor.transparent),
          decoration: buttonDecoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                    color: Theme.of(context).highlightColor,
                    width: 1.r
                ),
              ),
          elevation: buttonElevation,
        ),
        iconStyleData: IconStyleData(
          icon: icon ?? SvgPicture.asset(
            'assets/svg/ic_arrow_down.svg',
            color: Theme.of(context).iconTheme.color,
            width: 18.r,
          ),
          iconSize: iconSize ?? 16.r,
          iconEnabledColor: iconEnabledColor,
          iconDisabledColor: iconDisabledColor,
        ),
        dropdownStyleData: DropdownStyleData(
          //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
          maxHeight: dropdownHeight ?? 200.h,
          width: dropdownWidth ?? 140.w,
          padding: dropdownPadding,
          decoration: dropdownDecoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(6),
              ),
          elevation: dropdownElevation ?? 8,
          //Null or Offset(0, 0) will open just under the button. You can edit as you want.
          offset: offset,
          //Default is false to show menu below button
          isOverButton: false,
          scrollbarTheme: ScrollbarThemeData(
            radius: scrollbarRadius ?? Radius.circular(6.r),
            thickness: scrollbarThickness != null
                ? MaterialStateProperty.all<double>(scrollbarThickness!)
                : null,
            thumbVisibility: scrollbarAlwaysShow != null
                ? MaterialStateProperty.all<bool>(scrollbarAlwaysShow!)
                : null,
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: itemHeight ?? 40.h,
          padding: itemPadding ?? REdgeInsets.only(left: 15, right: 15),
        ),
      ),
    );
  }

  List<DropdownMenuItem<OptionItem<T>>> _buildOptionMenuItem(List<OptionItem<T>> items) {
    return items.map<DropdownMenuItem<OptionItem<T>>>((OptionItem<T> value) {
      return DropdownMenuItem<OptionItem<T>> (
        value: value,
        child: Container(
          alignment: valueAlignment,
          child: Text(
            value.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: 15.sp,
            ),
          ),
        ),
      );
    }).toList();
  }
}