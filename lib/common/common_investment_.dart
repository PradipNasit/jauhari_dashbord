import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jauhari_dashbord/Helper/color_helper.dart';
import 'package:jauhari_dashbord/common/common_text_widget.dart';

class DynamicTable<T> extends StatelessWidget {
  final List<String> headers;
  final List<T> data;
  final List<String Function(T)> valueExtractors;
  final void Function(T)? onEdit;
  final void Function(T)? onDelete;
  final RxInt editingRowIndex; // Track which row is editable
  final List<void Function(T, int, String)>? onChanged;
  final void Function(T)? onViewButtonPressed;
  final bool isReadOnly;

  DynamicTable({
    required this.headers,
    required this.data,
    required this.valueExtractors,
    required this.editingRowIndex,
    required this.onViewButtonPressed,
    this.onEdit,
    this.isReadOnly = true,
    this.onDelete,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorHelper.textFieldFillColor),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeaderRow(),
          ..._buildDataRows(),
        ],
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          ...headers.map((header) => _buildHeaderCell(header)).toList(),
          _buildHeaderCell('View'),
          _buildHeaderCell('Edit / Delete'),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String header) {
    return Expanded(
      child: Center(
        child: Text(
          header,
          style: const TextStyle(
            color: ColorHelper.switchTextColor,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDataRows() {
    return data.asMap().entries.map((entry) {
      int index = entry.key;
      T item = entry.value;

      return Obx(() {
        bool isEditable = editingRowIndex.value == index;

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            color: isEditable
                ? Colors.yellow.withOpacity(0.3)
                : (index.isEven ? Colors.grey[200] : Colors.white),
            borderRadius: BorderRadius.only(
              bottomRight: index + 1 == data.length
                  ? const Radius.circular(12)
                  : const Radius.circular(0),
              bottomLeft: index + 1 == data.length
                  ? const Radius.circular(12)
                  : const Radius.circular(0),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ..._buildValueCells(item, index, isEditable),
              _buildViewButton(item),
              _buildEditDeleteButtons(item, index, isEditable),
            ],
          ),
        );
      });
    }).toList();
  }

  List<Widget> _buildValueCells(T item, int index, bool isEditable) {
    return valueExtractors.asMap().entries.map((extractorEntry) {
      final extractorIndex = extractorEntry.key;
      final extractor = extractorEntry.value;

      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: TextField(
            textAlign: TextAlign.center,
            readOnly: !isEditable,
            controller: TextEditingController(
              text: extractor(item),
            ),
            onChanged: (value) {
              if (onChanged != null) {
                onChanged![extractorIndex](item, index, value);
                log(name: "DropDownValue", value);
              }
            },
            decoration: const InputDecoration(border: InputBorder.none),
            style: const TextStyle(fontSize: 15),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildViewButton(T item) {
    return Expanded(
      child: Center(
        child: ElevatedButton(
          onPressed: () => onViewButtonPressed?.call(item),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: ColorHelper.brownColor,
          ),
          child: CommonText(
            text: "View",
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildEditDeleteButtons(T item, int index, bool isEditable) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              isEditable ? Icons.check : Icons.edit,
              color: isEditable ? Colors.green : Colors.grey,
            ),
            onPressed: () {
              if (isEditable) {
                onEdit?.call(item);
                editingRowIndex.value = -1;
              } else {
                editingRowIndex.value = index;
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red.withOpacity(0.7)),
            onPressed: () => onDelete?.call(item),
          ),
        ],
      ),
    );
  }
}
