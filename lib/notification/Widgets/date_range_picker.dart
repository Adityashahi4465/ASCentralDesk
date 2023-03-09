import 'package:flutter/material.dart';

class CustomDateRangePicker extends StatefulWidget {
  final DateTimeRange initialDateRange;
  final DateTime firstDate;
  final DateTime lastDate;
  final Color backgroundColor;

  CustomDateRangePicker({
    required this.initialDateRange,
    required this.firstDate,
    required this.lastDate,
    this.backgroundColor = const Color(0xFF181D3D),
  });

  @override
  _CustomDateRangePickerState createState() => _CustomDateRangePickerState();
}

class _CustomDateRangePickerState extends State<CustomDateRangePicker> {
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _selectedDateRange = widget.initialDateRange;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.white,
          onPrimary: widget.backgroundColor,
          surface: widget.backgroundColor,
          onSurface: Colors.white,
        ),
        dialogBackgroundColor: widget.backgroundColor,
      ),
      child: Dialog(
        backgroundColor: widget.backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 300,
              child: CalendarDatePicker(
                initialDate: _selectedDateRange!.start,
                firstDate: widget.firstDate,
                lastDate: widget.lastDate,
                onDateChanged: (newStartDate) {
                  setState(() {
                    _selectedDateRange = DateTimeRange(
                      start: newStartDate,
                      end: _selectedDateRange!.end,
                    );
                  });
                },
              ),
            ),
            SizedBox(
              height: 50,
              child: Center(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(_selectedDateRange),
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
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
