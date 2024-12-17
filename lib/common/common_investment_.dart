import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jauhari_dashbord/Helper/color_helper.dart';
import 'package:jauhari_dashbord/base_layout.dart';
import 'package:jauhari_dashbord/common/common_text_widget.dart';
import 'package:jauhari_dashbord/responsive/common_builder.dart';
import 'package:jauhari_dashbord/view/user%20All%20Details/view/user_all_details.dart';

class DynamicTable<T> extends StatelessWidget {
  final List<String> headers;
  final List<T> data;
  final List<String Function(T)> valueExtractors;
  final void Function(T)? onEdit;
  final void Function(T)? onDelete;
  final RxInt editingRowIndex; // Track which row is editable
  final List<void Function(T, int, String)>? onChanged;
  final void Function(T)?onViewButtonPressed;
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
            // Table Headers
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                children: [
                  ...headers
                      .map(
                        (header) => Expanded(
                          child: Center(
                            child: Text(
                              header,
                              style: const TextStyle(
                                  color: ColorHelper.switchTextColor,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'View',
                        style: TextStyle(color: ColorHelper.switchTextColor),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Edit / Delete',
                        style: TextStyle(color: ColorHelper.switchTextColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Table Rows
            ...data.asMap().entries.map((entry) {
              int index = entry.key;
              T item = entry.value;

              return Obx(() {
                bool isEditable = editingRowIndex.value == index;

                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  decoration: BoxDecoration(
                    color: isEditable
                        ? Colors.yellow.withOpacity(0.3) // Highlight color for edit mode
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
                      // Editable Text Fields
                      ...valueExtractors.asMap().entries.map(
                            (extractorEntry) {
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
                                    log(name: "DropDownValue", value.toString());

                                  }
                                },
                                decoration: const InputDecoration(border: InputBorder.none),
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          );
                        },
                      ),

                      // View Button
                      Expanded(
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (onViewButtonPressed != null) {
                                onViewButtonPressed!(item); // Properly invoke the callback
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
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
                      ),

                      // Edit/Delete Actions
                      Expanded(
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
                                  // Save action
                                  if (onEdit != null) onEdit!(item);
                                  editingRowIndex.value = -1; // Reset editing
                                } else {
                                  // Start editing
                                  editingRowIndex.value = index;
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red.withOpacity(0.7)),
                              onPressed: onDelete != null ? () => onDelete!(item) : null,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });

            }).toList(),
          ],
        ),

    );
  }
}
