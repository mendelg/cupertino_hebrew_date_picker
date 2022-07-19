import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kosher_dart/kosher_dart.dart';

class CupertinoHebrewDatePicker extends StatefulWidget {
  final BuildContext context;
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<DateTime> onConfirm;

  final DateTime initialDate;
  final String confirmText;
  final TextStyle confirmTextStyle;
  final TextStyle todaysDateTextStyle;

  CupertinoHebrewDatePicker({
    Key? key,
    required this.context,
    required this.onDateChanged,
    required this.onConfirm,
    DateTime? initialDate,
    String? confirmText,
    TextStyle? confirmTextStyle,
    TextStyle? todaysDateTextStyle,
  })  : initialDate = initialDate ?? DateTime.now(),
        confirmText = confirmText ?? "Confirm",
        confirmTextStyle = confirmTextStyle ??
            const TextStyle(
              color: CupertinoColors.destructiveRed,
              fontWeight: FontWeight.w600,
            ),
        todaysDateTextStyle = todaysDateTextStyle ??
            const TextStyle(
              color: CupertinoColors.activeBlue,
              fontWeight: FontWeight.w600,
            ),
        super(key: key);

  @override
  State<CupertinoHebrewDatePicker> createState() =>
      _CupertinoHebrewDatePickerState();
}

class _CupertinoHebrewDatePickerState extends State<CupertinoHebrewDatePicker> {
  final _hebrewDateFormatter = HebrewDateFormatter();
  late var jewishDate = JewishDate.fromDateTime(widget.initialDate);

  late final _dayScrollController = FixedExtentScrollController(
      initialItem: jewishDate.getJewishDayOfMonth() - 1);
  late final _monthScrollController =
      FixedExtentScrollController(initialItem: jewishDate.getJewishMonth() - 1);
  late final _yearScrollController = FixedExtentScrollController(
      initialItem:
          int.parse(jewishDate.getJewishYear().toString().substring(2, 4)));

  late var todaysDay = JewishDate().getJewishDayOfMonth();
  late var todaysMonth = JewishDate().getJewishMonth();
  late var todaysYear = JewishDate().getJewishYear();

  var selectedDayIndex = 0;
  var selectedMonthIndex = 0;
  var selectedYearIndex = 0;
  final _days = [
    "א",
    "ב",
    "ג",
    "ד",
    "ה",
    "ו",
    "ז",
    "ח",
    "ט",
    "י",
    "יא",
    "יב",
    "יג",
    "יד",
    "טו",
    "טז",
    "יז",
    "יח",
    "יט",
    "כ",
    "כא",
    "כב",
    "כג",
    "כד",
    "כה",
    "כו",
    "כז",
    "כח",
    "כט",
    "ל"
  ];
  final _months = [
    "ניסן",
    "אייר",
    "סיוון",
    "תמוז",
    "אב",
    "אלול",
    "תשרי",
    "חשוון",
    "כסלו",
    "טבת",
    "שבט",
    "אדר א",
    "אדר ב",
  ];
  final _years = [for (var i = 5700; i < 7000; i += 1) i];

  _handleOnChange() {
    var day = selectedDayIndex == 0
        ? jewishDate.getJewishDayOfMonth()
        : selectedDayIndex + 1;
    var month = selectedMonthIndex == 0
        ? jewishDate.getJewishMonth()
        : selectedMonthIndex + 1;
    var year = selectedYearIndex == 0
        ? jewishDate.getJewishYear()
        : _years[selectedYearIndex];

    try {
      jewishDate = JewishDate.initDate(
          jewishYear: year, jewishMonth: month, jewishDayOfMonth: day);
    } catch (e) {
      // Leap year

      jewishDate = JewishDate.initDate(
          jewishYear: year, jewishMonth: 12, jewishDayOfMonth: day);
    }

    widget.onDateChanged(jewishDate.getGregorianCalendar());
  }

  _handleOnConfirm() {
    widget.onConfirm(jewishDate.getGregorianCalendar());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return _buildLayout();
  }

  Widget _buildDayPicker() {
    return Expanded(
      child: CupertinoPicker(
        scrollController: _dayScrollController,
        itemExtent: 30,
        onSelectedItemChanged: (index) {
          setState(() {
            selectedDayIndex = index;
            _handleOnChange();
          });
        },
        children: _days.map((day) {
          return Center(child: Text(day));
        }).toList(),
      ),
    );
  }

  Widget _buildMonthPicker() {
    return Expanded(
      child: CupertinoPicker(
        scrollController: _monthScrollController,
        itemExtent: 30,
        onSelectedItemChanged: (index) {
          setState(() {
            selectedMonthIndex = index;
            _handleOnChange();
          });
        },
        children: _months.map((month) {
          return Center(child: Text(month));
        }).toList(),
      ),
    );
  }

  Widget _buildYearPicker() {
    return Expanded(
      child: CupertinoPicker(
        scrollController: _yearScrollController,
        itemExtent: 30,
        onSelectedItemChanged: (index) {
          setState(() {
            selectedYearIndex = index;
            _handleOnChange();
          });
        },
        children: _years.map((year) {
          return Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_hebrewDateFormatter.formatHebrewNumber(year)),
                const SizedBox(width: 5),
                Text(year.toString()),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  _buildLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: CupertinoButton(
                child: Text(
                  widget.confirmText,
                  style: widget.confirmTextStyle,
                ),
                onPressed: _handleOnConfirm,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: CupertinoButton(
                child: Text(
                  "Todays date",
                  style: widget.todaysDateTextStyle,
                ),
                onPressed: () {
                  _scroll();
                },
              ),
            ),
          ],
        ),
        _buildYearPicker(),
        _buildMonthPicker(),
        _buildDayPicker(),
      ],
    );
  }

  void _scroll() {
    _yearScrollController.animateToItem(_years.indexOf(todaysYear),
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
    _dayScrollController.animateToItem(todaysDay - 1,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
    _monthScrollController.animateToItem(todaysMonth - 1,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  @override
  void dispose() {
    _dayScrollController.dispose();
    _monthScrollController.dispose();
    _yearScrollController.dispose();

    super.dispose();
  }
}

void showHebrewCupertinoDatePicker({
  required BuildContext context,
  required ValueChanged<DateTime> onDateChanged,
  required ValueChanged<DateTime> onConfirm,
  DateTime? initialDate,
  String? confirmText,
  TextStyle? confirmTextStyle,
  TextStyle? todaysDateTextStyle,
}) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: CupertinoHebrewDatePicker(
          initialDate: initialDate,
          context: context,
          onConfirm: onConfirm,
          onDateChanged: onDateChanged,
          confirmText: confirmText,
          confirmTextStyle: confirmTextStyle,
          todaysDateTextStyle: todaysDateTextStyle,
        ),
      );
    },
  );
}
