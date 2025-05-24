import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insure_mate/extensions/string_extensions.dart';
import 'package:insure_mate/generic_models/policy_model.dart';
import 'package:insure_mate/helper/app_helper.dart';
import 'package:insure_mate/helper/app_string.dart';
import 'package:insure_mate/screens/afterlogin_screens/1_home/add_policy_screen/service/add_policy_service.dart';
import 'package:insure_mate/widget/app_button_widget.dart';
import 'package:insure_mate/widget/app_textformfield_widget.dart';
import 'package:insure_mate/widget/no_leading_zero_formatter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../theme/app_color.dart';
import '../../../../../theme/app_text_style.dart';

class AddPolicyScreen extends StatefulWidget {
  const AddPolicyScreen({super.key});

  @override
  State<AddPolicyScreen> createState() => _AddPolicyScreenState();
}

class _AddPolicyScreenState extends State<AddPolicyScreen> {
  final _formGlobalKey = GlobalKey<FormState>();
  final TextEditingController _policyholderNameController =
      TextEditingController();
  final TextEditingController _policyNumberController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _premiumAmountController =
      TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _fupDateController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  PremiumMode _selectedMode = PremiumMode.yearly;
  DateTime? _startDateDateTime;
  DateTime? _FUPDateTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _startDateController.text = "".todayDate();
    _startDateDateTime = DateTime.now();
  }

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formGlobalKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                spacing: 20,
                children: [
                  AppTextFormField(
                    textFieldController: _policyholderNameController,
                    placeholderText: AppString.policyholderNameText,
                    maxLength: 50,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    textCapitalization: TextCapitalization.words,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppString.policyholderNameErrorText;
                      }
                      return null;
                    },
                  ),
        
                  AppTextFormField(
                    textFieldController: _phoneNumberController,
                    textInputType: TextInputType.number,
                    placeholderText: AppString.phoneNumberText,
                    maxLength: 10,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value != null &&
                          value.isNotEmpty &&
                          value.length < 10) {
                        return AppString.phoneNumberLengthErrorText;
                      }
                      return null;
                    },
                  ),
        
                  AppTextFormField(
                    textFieldController: _policyNumberController,
                    textInputType: TextInputType.number,
                    placeholderText: AppString.policyNumberText,
                    maxLength: 9,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppString.policyNumberErrorText;
                      }
                      if (value.length < 9) {
                        return AppString.policyNumberLengthErrorText;
                      }
                      return null;
                    },
                  ),
        
                  AppTextFormField(
                    textFieldController: _premiumAmountController,
                    textInputType: TextInputType.numberWithOptions(
                      decimal: false,
                    ),
                    placeholderText:
                        "${AppString.premiumAmountText} (${AppHelper.rupee})",
                    maxLength: 9,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [NoLeadingZeroFormatter()],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppString.premiumAmountErrorText;
                      }
        
                      var doubleValue = double.parse(value);
        
                      if (doubleValue == 0) {
                        return AppString.premiumAmountNotZeroErrorText;
                      }
        
                      return null;
                    },
                  ),
        
                  DropdownButtonFormField(
                    value: _selectedMode,
                    style: AppTextStyle.bodyMedium.apply(
                      color: AppColor.textPrimary,
                    ),
                    decoration: InputDecoration(
                      labelText: AppString.premiumModeText,
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
                        return AppString.premiumModeErrorText;
                      }
                    },
                    items:
                        PremiumMode.values.map((mode) {
                          return DropdownMenuItem(
                            value: mode,
                            child: Text(mode.rawValue),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedMode = value!;
                      });
                    },
                  ),
        
                  AppTextFormField(
                    textFieldController: _startDateController,
                    placeholderText: AppString.startDateText,
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppString.startDateErrorText;
                      }
                      return null;
                    },
                    onTap: () async {
                      DateTime? pickedDate = await _showDatePicker(
                        AppString.startDateText,
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _startDateDateTime = pickedDate;
                          _startDateController.text = DateFormat(
                            "dd/MM/yyyy",
                          ).format(pickedDate);
                        });
                      }
                    },
                  ),
        
                  AppTextFormField(
                    textFieldController: _fupDateController,
                    placeholderText: AppString.fupDateText,
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await _showDatePicker(
                        AppString.fupDateText,
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _FUPDateTime = pickedDate;
                          _fupDateController.text = DateFormat(
                            "dd/MM/yyyy",
                          ).format(pickedDate);
                        });
                      }
                    },
                  ),
        
                  AppTextFormField(
                    textFieldController: _notesController,
                    placeholderText: AppString.notesText,
                    maxLength: 50,
                    textCapitalization: TextCapitalization.sentences,
                  ),
        
                  SizedBox(height: 5),
        
                  AppButton(
                    buttonName: AppString.submitText,
                    onTap: submitButtonTap,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<DateTime?> _showDatePicker(String datePickerName) async {
    DateTime? dateTime = await showDatePicker(
      context: context,
      helpText: datePickerName,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    return dateTime;
  }

  void submitButtonTap() async {
    if (_formGlobalKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      final policyholderName = _policyholderNameController.text;
      final policyNo = _policyNumberController.text;
      final premiumAmount = _premiumAmountController.text;
      final startDate = _startDateDateTime?.millisecondsSinceEpoch;
      final fupDate = _FUPDateTime?.millisecondsSinceEpoch;
      final premiumMode = _selectedMode;
      final notes = _notesController.text;
      final phoneNumber = _phoneNumberController.text;
      int nextDueDate;

      if (fupDate != null) {
        nextDueDate = fupDate;
      } else {
        final dueDate = calculateNextDueDate(
          startDate: _startDateDateTime!,
          premiumMode: premiumMode,
        );
        print("due date is $dueDate");

        nextDueDate = dueDate.millisecondsSinceEpoch;
      }

      final _addPolicyService = context.read<AddPolicyService>();
      bool isSucceeded = await _addPolicyService.addPolicy(
        Policy(
          policyholderName,
          policyNo,
          premiumAmount,
          premiumMode,
          startDate!,
          fupDate,
          notes,
          nextDueDate,
          phoneNumber,
        )
      );

      if (isSucceeded) {
        Navigator.pop(context);
      }
    }
  }

  DateTime calculateNextDueDate({
    required DateTime startDate,
    required PremiumMode
    premiumMode, // 'monthly', 'quarterly', 'half-yearly', 'yearly'
    DateTime? fromDate,
  }) {
    final DateTime today = fromDate ?? DateTime.now();

    final Map<PremiumMode, int> frequencyMap = {
      PremiumMode.monthly: 1,
      PremiumMode.quarterly: 3,
      PremiumMode.halfYearly: 6,
      PremiumMode.yearly: 12,
    };

    final int intervalMonths = frequencyMap[premiumMode] ?? 3;
    DateTime nextDate = startDate;

    while (!nextDate.isAfter(today)) {
      int newMonth = nextDate.month + intervalMonths;
      int newYear = nextDate.year + (newMonth - 1) ~/ 12;
      newMonth = ((newMonth - 1) % 12) + 1;

      // Handle Feb 29 edge case
      int day = nextDate.day;
      int daysInMonth = DateTime(newYear, newMonth + 1, 0).day;
      if (day > daysInMonth) {
        day = daysInMonth;
      }

      nextDate = DateTime(newYear, newMonth, day);
    }

    return nextDate;
  }
}
