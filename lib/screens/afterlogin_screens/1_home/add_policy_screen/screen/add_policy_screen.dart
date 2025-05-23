import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insure_mate/helper/app_helper.dart';
import 'package:insure_mate/helper/app_string.dart';
import 'package:insure_mate/screens/afterlogin_screens/1_home/add_policy_screen/service/add_policy_service.dart';
import 'package:insure_mate/widget/app_button_widget.dart';
import 'package:insure_mate/widget/app_textformfield_widget.dart';
import 'package:insure_mate/widget/no_leading_zero_formatter.dart';
import 'package:intl/intl.dart';

import '../../../../../theme/app_color.dart';
import '../../../../../theme/app_text_style.dart';

class AddPolicyScreen extends StatefulWidget {
  const AddPolicyScreen({super.key});

  @override
  State<AddPolicyScreen> createState() => _AddPolicyScreenState();
}

class _AddPolicyScreenState extends State<AddPolicyScreen> {
  final _formGlobalKey = GlobalKey<FormState>();
  final TextEditingController policyholderNameController =
      TextEditingController();
  final TextEditingController policyNumberController = TextEditingController();
  final TextEditingController premiumAmountController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController lastPaidDateController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  PremiumMode _selectedMode = PremiumMode.yearly;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          AppString.addPolicyText,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formGlobalKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 20,
              children: [
                AppTextFormField(
                  textFieldController: policyholderNameController,
                  placeholderText: "Policyholder Name",
                  maxLength: 50,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the policyholder name";
                    }
                    return null;
                  },
                ),
        
                AppTextFormField(
                  textFieldController: policyNumberController,
                  textInputType: TextInputType.number,
                  placeholderText: "Policy Number",
                  maxLength: 9,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the policy number";
                    }
                    if (value.length < 9) {
                      return "Policy number must be of 9 digits";
                    }
                    return null;
                  },
                ),
        
                AppTextFormField(
                  textFieldController: premiumAmountController,
                  textInputType: TextInputType.numberWithOptions(decimal: false),
                  placeholderText: "Premium Amount (${AppHelper.rupee})",
                  maxLength: 9,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [NoLeadingZeroFormatter()],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the premium amount";
                    }
        
                    var intValue = int.parse(value);
        
                    if (intValue == 0) {
                      premiumAmountController.text = "0";
                      return "Premium amount can't be 0";
                    }
        
                    return null;
                  },
                ),
        
                DropdownButtonFormField(
                  value: _selectedMode,
                  decoration: InputDecoration(
                    labelText: "Premium Mode",
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: AppColor.error, width: 1.5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: AppColor.error, width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: AppColor.secondary,
                        width: 1.5,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "Please select premium mode";
                    }
                  },
                  items:
                      PremiumMode.values.map((mode) {
                        return DropdownMenuItem(
                          value: mode,
                          child: Text(_getPremiumModeText(mode)),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedMode = value!;
                    });
                  },
                ),
        
                AppTextFormField(
                  textFieldController: startDateController,
                  placeholderText: "Start Date",
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select the start date";
                    }
                    return null;
                  },
                  onTap: () async {
                    String? pickedDate = await _showDatePicker("Start Date");
                    if (pickedDate != null) {
                      setState(() {
                        startDateController.text = pickedDate;
                      });
                    }
                  }
                ),

                AppTextFormField(
                    textFieldController: lastPaidDateController,
                    placeholderText: "Last Paid Date",
                    readOnly: true,
                    onTap: () async {
                      String? pickedDate = await _showDatePicker("Last Paid Date");
                      if (pickedDate != null) {
                        setState(() {
                          startDateController.text = pickedDate;
                        });
                      }
                    }
                ),

                AppTextFormField(
                  textFieldController: policyholderNameController,
                  placeholderText: "Notes",
                  maxLength: 50,
                ),
        
                SizedBox(height: 5,),
        
                AppButton(
                  buttonName: "Submit",
                  onTap: () {
                    if (_formGlobalKey.currentState!.validate()) {
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getPremiumModeText(PremiumMode mode) {
    switch (mode) {
      case PremiumMode.yearly:
        return "Yearly";
      case PremiumMode.halfYearly:
        return "Half Yearly";
      case PremiumMode.quarterly:
        return "Quarterly";
      case PremiumMode.monthly:
        return "Monthly";
    }
  }

  Future<String?> _showDatePicker(String datePickerName) async {
    DateTime? dateTime = await showDatePicker(
        context: context,
        helpText: datePickerName,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now()
    );

    if(dateTime != null) {
      return DateFormat("dd/MM/yyyy").format(dateTime);
    }

    return null;
  }
}
