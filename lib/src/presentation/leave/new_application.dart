import 'package:delivery_app/src/core/utiils_lib/extensions.dart';
import 'package:delivery_app/src/logic/provider/leave_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewApplicationTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final applicationProvider = Provider.of<LeaveProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "How many days?",
                style: context.buttonTestStyle,
              ),
              DropdownButton<int>(
                value: applicationProvider.selectedDays,
                onChanged: (value) {
                  if (value != null) {
                    applicationProvider.updateSelectedDays(value);
                  }
                },
                items: List.generate(30, (index) {
                  return DropdownMenuItem(
                    value: index + 1,
                    child: Text('${index + 1} days'),
                  );
                }),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "From:",
                style: context.buttonTestStyle,
              ),
              InkWell(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: applicationProvider.fromDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          primaryColor: context.appColor
                              .primarycolor, // Change the color of the header
                          // Change the color of the selected date
                          colorScheme: ColorScheme.light(
                              primary: context.appColor
                                  .primarycolor), // Change the color of the calendar itself
                          buttonTheme: ButtonThemeData(
                              textTheme: ButtonTextTheme
                                  .primary), // Change button color
                          dialogBackgroundColor: Colors
                              .white, // Set the background color of the dialog to white
                        ),
                        child: child ?? SizedBox(),
                      );
                    },
                  );
                  if (pickedDate != null) {
                    applicationProvider.updateFromDate(pickedDate);
                  }
                },
                child: Text(
                  applicationProvider.fromDate
                          ?.toLocal()
                          .toString()
                          .split(' ')[0] ??
                      'Select Date',
                  style: context.buttonTestStyle,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "To:",
                style: context.buttonTestStyle,
              ),
              InkWell(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: applicationProvider.toDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          primaryColor: context.appColor
                              .primarycolor, // Change the color of the header
                          // Change the color of the selected date
                          colorScheme: ColorScheme.light(
                              primary: context.appColor
                                  .primarycolor), // Change the color of the calendar itself
                          buttonTheme: ButtonThemeData(
                              textTheme: ButtonTextTheme
                                  .primary), // Change button color
                          dialogBackgroundColor: Colors
                              .white, // Set the background color of the dialog to white
                        ),
                        child: child ?? SizedBox(),
                      );
                    },
                  );
                  if (pickedDate != null) {
                    applicationProvider.updateToDate(pickedDate);
                  }
                },
                child: Text(
                  applicationProvider.toDate
                          ?.toLocal()
                          .toString()
                          .split(' ')[0] ??
                      'Select Date',
                  style: context.buttonTestStyle,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Reason for leave:",
                style: context.buttonTestStyle,
              ),
              DropdownButton<String>(
                value: applicationProvider.selectedReason.isEmpty
                    ? null
                    : applicationProvider.selectedReason,
                onChanged: (value) {
                  if (value != null) {
                    applicationProvider.updateSelectedReason(value);
                  }
                },
                items: <String>['Vacation', 'Sick', 'Personal', 'Other']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              labelText: 'Comments',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
            onChanged: (value) {
              // Handle comments input if needed
            },
          ),
        ],
      ),
    );
  }
}

class MyApplicationTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('My Application Tab'));
  }
}
