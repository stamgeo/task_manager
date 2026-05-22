import 'package:flutter/material.dart';

class TaskFilterSegmentedButton extends StatelessWidget {
  const TaskFilterSegmentedButton({
    super.key,
    required this.onSelectionChanged,
    required this.selectedFilter
  });

  final void Function(Set<String> params) onSelectionChanged;
  final Set<String> selectedFilter;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      segments: <ButtonSegment<String>>[
        ButtonSegment(value: 'done', label: Text('done')),
        ButtonSegment(value: 'pending', label: Text('pending')),
      ],
      selected: selectedFilter,
      emptySelectionAllowed: true,
      onSelectionChanged: onSelectionChanged,
    );
  }
}
