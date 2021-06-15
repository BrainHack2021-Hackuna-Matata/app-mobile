import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MeetupCreatorForm extends StatefulWidget {
  final Function _submitForm;
  MeetupCreatorForm(this._submitForm);

  @override
  State<MeetupCreatorForm> createState() {
    return _MyFormState();
  }
}

class _MyFormState extends State<MeetupCreatorForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {
    'postalCode': '',
    'type': '',
    'capacity': 0,
    'dateTime': '',
  };

  var _dropdownOption = "Cards";

  String? _postalCodeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Postal code required";
    } else if (value.length != 6 || num.tryParse(value) == null) {
      return "Invalid postal code";
    } else {
      return null;
    }
  }

  String? _capacityValidator(String? value) {
    if (value != null && num.tryParse(value) == null) {
      return "Must be an integer";
    } else if (num.tryParse(value!)! > 8) {
      return "Must be less than 8";
    } else {
      return null;
    }
  }

  String? _dateTimeValidator(DateTime? value) {
    if (value == null) {
      return "Date time required";
    } else if (value.compareTo(DateTime.now()) <= 0) {
      return "Must be in the future";
    } else {
      return null;
    }
  }

  void _submitForm() {
    final formState = _formKey.currentState;

    if (formState!.validate()) {
      formState.save();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Submitted")));
      widget._submitForm(formData);
    }
    // Submit form API call
    
    // print(formData);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            validator: _postalCodeValidator,
            onSaved: (String? value) {
              formData['postalCode'] = value;
            },
            decoration: InputDecoration(
              labelText: "Location (Postal code)",
            ),
            keyboardType: TextInputType.number,
          ),
          DropdownButtonFormField<String>(
            items: ["Cards", "Chess", "Mahjong"].map((item) {
              return DropdownMenuItem(child: Text(item), value: item);
            }).toList(),
            value: _dropdownOption,
            onChanged: (newOption) {
              setState(() {
                _dropdownOption = newOption!;
              });
            },
            onSaved: (String? value) {
              formData['type'] = value;
            },
            decoration: InputDecoration(labelText: "Type"),
          ),
          TextFormField(
            validator: _capacityValidator,
            onSaved: (String? value) {
              formData['capacity'] = num.tryParse(value!);
            },
            decoration: InputDecoration(
              labelText: "Capacity",
            ),
            keyboardType: TextInputType.number,
          ),
          DateTimeField(
            format: DateFormat("yyyy-MM-dd hh:mm aa"),
            onShowPicker: (context, currentValue) async {
              final date = await showDatePicker(context: context, firstDate: DateTime(1900), initialDate: currentValue ?? DateTime.now(), lastDate: DateTime(2100));
              if (date != null) {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                );
                return DateTimeField.combine(date, time);
              } else {
                return currentValue;
              }
            },
            validator: _dateTimeValidator,
            onSaved: (DateTime? value) {
              formData['dateTime'] = value!.toIso8601String();
            },
            decoration: InputDecoration(labelText: "Date and Time"),
          ),
          ElevatedButton(onPressed: _submitForm, child: Text("Submit"))
        ],
      ),
    );
  }
}
