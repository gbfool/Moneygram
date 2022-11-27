import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePickerScreen extends StatefulWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;
  DatePickerScreen(
      {Key? key, required this.selectedDate, required this.onDateSelected});

  @override
  DatePickerScreenState createState() => DatePickerScreenState();
}

/// State for DatePickerScreen
class DatePickerScreenState extends State<DatePickerScreen> {
  late DateTime _selectedDate;
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is DateTime) {
        _selectedDate = args.value;
      }
    });
  }

  @override
  void initState() {
    _selectedDate = widget.selectedDate ?? DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                    child: Text(
                  "Choose Date",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )),
                Spacer(),
                _saveButton()
              ],
            ),
            const SizedBox(height: 16),
            Container(
                height: 400,
                child: Container(
                  child: SfDateRangePicker(
                    onSelectionChanged: _onSelectionChanged,
                    todayHighlightColor: Colors.black,
                    selectionColor: Colors.black,
                    initialSelectedDate: DateTime.now(),
                    selectionTextStyle:
                        TextStyle(color: Colors.white, fontSize: 18),
                    showNavigationArrow: true,
                    headerStyle: DateRangePickerHeaderStyle(
                        textStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    monthViewSettings: DateRangePickerMonthViewSettings(
                        dayFormat: "EEE",
                        viewHeaderStyle: DateRangePickerViewHeaderStyle(
                            textStyle: TextStyle(
                                color: Colors.black.withOpacity(0.5)))),
                    monthCellStyle: DateRangePickerMonthCellStyle(
                        textStyle: TextStyle(color: Colors.black, fontSize: 18),
                        todayTextStyle: TextStyle(
                            color: Colors.black.withOpacity(0.9),
                            fontSize: 18)),
                    yearCellStyle: DateRangePickerYearCellStyle(
                      textStyle: const TextStyle(color: Colors.black),
                      todayTextStyle: const TextStyle(color: Colors.black),
                    ),
                  ),
                ))
          ],
        ));
  }

  Widget _saveButton() {
    return InkWell(
      onTap: () {
        widget.onDateSelected(_selectedDate);
        Navigator.of(context).pop();
      },
      child: Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        child: Text(
          "Done",
          style: TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
