import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:senat_unit_bv/theme.dart';

class AddMeetingBs {
  static Future show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => _Bs(),
    );
  }
}

class _Bs extends StatefulWidget {
  @override
  State<_Bs> createState() => _BsState();
}

class _BsState extends State<_Bs> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Creeaza sendinta',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppPalette.primaryColor),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppPalette.primaryColor),
                          ),
                          labelText: 'Titlu',
                        ),
                      ),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppPalette.primaryColor),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppPalette.primaryColor),
                          ),
                          labelText: 'Descriere',
                        ),
                        maxLines: 5,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Center(
                          child: Text(
                            'Ora',
                            style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const Divider(height: 16),
                      SizedBox(
                        width: 100,
                        child: TimePickerSpinner(
                          minutesInterval: 1,
                          onTimeChange: _handleTimeChange,
                          alignment: Alignment.center,
                          isForce2Digits: true,
                          is24HourMode: true,
                          itemHeight: Theme.of(context).textTheme.headline5!.fontSize ?? 0 + 10,
                          itemWidth: 30,
                          normalTextStyle: TextStyle(
                            fontSize: Theme.of(context).textTheme.subtitle2!.fontSize,
                            color: Colors.black87,
                          ),
                          highlightedTextStyle: TextStyle(
                            fontSize: Theme.of(context).textTheme.subtitle2!.fontSize ?? 0 + 10,
                            color: AppPalette.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Center(
                          child: Text(
                            'Data',
                            style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const Divider(height: 16),
                      SizedBox(
                        height: 80,
                        child: ScrollDatePicker(
                          selectedDate: _selectedDate,
                          locale: const Locale('en'),
                          minimumDate: DateTime.now(),
                          maximumDate: DateTime.now().add(
                            const Duration(days: 180),
                          ),
                          options: const DatePickerOptions(
                            isLoop: false,
                          ),
                          onDateTimeChanged: _handleDateChange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(
                  height: 16,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _handleOnCreate,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Creeaza'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleDateChange(DateTime date) {
    final newDate = DateTime(
      date.year,
      date.month,
      date.day,
      _selectedDate.hour,
      _selectedDate.minute,
    );

    setState(() {
      _selectedDate = newDate;
    });
  }

  void _handleTimeChange(DateTime time) {
    final newDate = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      time.hour,
      time.minute,
    );

    setState(() {
      _selectedDate = newDate;
    });
  }

  void _handleOnCreate() {
    //TODO add validations
    final data = {
      "title": _titleController.text,
      "description": _descriptionController.text,
      "startDate": _selectedDate.toUtc().toIso8601String(),
    };

    Navigator.of(context).pop(data);
  }
}
