import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insure_mate/generic_models/policy_model.dart';
import 'package:insure_mate/helper/app_string.dart';
import 'package:insure_mate/providers/policy_provider/policy_provider.dart';
import 'package:insure_mate/theme/app_color.dart';
import 'package:insure_mate/widget/no_leading_space_formatter.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchTextEditingController = TextEditingController();
  List<Policy> _allPolicies = [];
  List<Policy> _searchedPolicies = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchTextEditingController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: "Type name or policy number",

            suffixIcon: IconButton(
              onPressed: openVoiceRecognition,
              icon: Icon(Icons.mic),
            ),
          ),
          onChanged: makeSearchedPolicy,
          inputFormatters: [NoLeadingSpaceFormatter()],
        ),
      ),

      body: Consumer<PolicyProvider>(
        builder: (searchContext, provider, _) {
          _allPolicies = provider.getAllPolicies();

          return Container(
            color: AppColor.background,
            child:
                _searchedPolicies.isNotEmpty
                    ? ListView.builder(
                      itemCount: _searchedPolicies.length,
                      itemBuilder: (_, index) {
                        return ListTile(
                          title: Text(
                            _searchedPolicies[index].policyholderName,
                          ),
                        );
                      },
                    )
                    : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child:
                            searchTextEditingController.text.isNotEmpty
                                ? Text("No policy found!")
                                : Text(
                                  "Start typing a name or policy number to search, or tap the mic to search by voice.",
                                ),
                      ),
                    ),
          );
        },
      ),
    );
  }

  void makeSearchedPolicy(String searchKey) {
    if (searchKey.isEmpty) {
      _searchedPolicies.clear();
      setState(() {});
      return;
    }

    _searchedPolicies =
        _allPolicies.where((policy) {
          final lowerSearchKey = searchKey.toLowerCase();
          return policy.policyholderName.toLowerCase().contains(
                lowerSearchKey,
              ) ||
              policy.policyNo.toLowerCase().contains(lowerSearchKey);
        }).toList();

    setState(() {});
  }

  void openVoiceRecognition() {}
}
