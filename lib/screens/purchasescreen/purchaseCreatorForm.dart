import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../components/notifier.dart';
import 'package:provider/provider.dart';
import './submitPurchase.dart';

class PurchaseCreatorForm extends StatefulWidget {
  final Function _submitForm;
  PurchaseCreatorForm(this._submitForm);

  @override
  State<PurchaseCreatorForm> createState() {
    return _MyFormState();
  }
}

class _MyFormState extends State<PurchaseCreatorForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {
    'blkNum': '',
    'type': '',
    'dateTime': '',
    'details' :'',
  };

  var _dropdownOption = "Groceries Needed";

  String? _blkNumValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Blk Number Required";
    } else if (value.contains('blk') || value.contains('Blk') || value.contains('block') || value.contains('Block') || value.contains('BLK')) {
      return "Please enter only the Block Number (without 'Blk'))";
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

   String? _detailsValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter details of your request";
    } else if (value.length < 12 ) {
      return "Please enter more details";
    } else if (value.length > 400 ) {
      return "Please enter more details";
    } else {
      return null;
    }
  }

  void _submitForm(UserNotifier user) {
    final formState = _formKey.currentState;


    if (formState!.validate()) {
      formState.save();
      SubmitPurchase(user,formData['type'],formData['details'],formData['blkNum'],formData['dateTime']); ///settle arguments
      print("submit stage 1");
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
      child: SingleChildScrollView(
              child:  Consumer<UserNotifier>(builder: (context, user, child) {
                return Column( 
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              validator: _blkNumValidator,
              onSaved: (String? value) {
                formData['blkNum'] = value;
              },
              decoration: InputDecoration(
                labelText: "Block Number",
              ),
            ),
            DropdownButtonFormField<String>(
              items: ["Groceries Needed", "Meal Needed"].map((item) {
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
            TextFormField(
              validator: _detailsValidator,
              onSaved: (String? value) {
                formData['details'] = value;
              },
              decoration: InputDecoration(
                labelText: "Details",
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 8,
              maxLength: 300,
            ),
            
            ElevatedButton(onPressed: ()=>_submitForm(user) , child: Text("Submit"))
          ],
                );
              }
          )
        )
      
    );
  }
}
