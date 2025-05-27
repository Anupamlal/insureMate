import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insure_mate/generic_models/policy_model.dart';
import 'package:insure_mate/helper/app_string.dart';
import 'package:insure_mate/providers/policy_provider/policy_provider.dart';
import 'package:insure_mate/screens/afterlogin_screens/2_search/search_screen/Widget/policy_search_cell_widget.dart';
import 'package:insure_mate/theme/app_color.dart';
import 'package:insure_mate/theme/app_text_style.dart';
import 'package:insure_mate/widget/no_leading_space_formatter.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchTextEditingController = TextEditingController();
  List<Policy> _allPolicies = [];
  List<Policy> _searchedPolicies = [];
  List<String> _recentSearch = ['Anupam', 'Anup', '8198806', 'Rupam', 'Deepam'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchTextEditingController.addListener(_makeSearchedPolicy);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: TextField(
          controller: _searchTextEditingController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: "Type name, policy no. or mobile",

            suffixIcon: IconButton(
              onPressed: _openVoiceRecognition,
              icon: Icon(Icons.mic),
            ),
          ),
          inputFormatters: [NoLeadingSpaceFormatter()],
        ),
      ),

      body: Consumer<PolicyProvider>(
        builder: (searchContext, provider, _) {
          _allPolicies = provider.getAllPolicies();

          return Container(
            color: AppColor.background,
            child: _getSearchListBody((searchKey){
              _searchTextEditingController.text = searchKey;
            }),
          );
        },
      ),
    );
  }

  void _makeSearchedPolicy() {

    print("_makeSearchedPolicy gets caled");
    String searchKey = _searchTextEditingController.text;

    print("_makeSearchedPolicy $searchKey");

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

  void _openVoiceRecognition() {}

  Widget _getSearchListBody(Function(String) onTap) {
    if (_searchTextEditingController.text.isEmpty) {
      Widget? recentSearchList = _getRecentSearchList(onTap);
      if (recentSearchList != null) {
        return recentSearchList;
      }

      return _getWidgetForNoRecentOrSearchResults();
    }

    return _searchedPolicies.isNotEmpty
        ? ListView.builder(
          itemCount: _searchedPolicies.length,
          itemBuilder: (_, index) {
            return PolicySearchCell(policy: _searchedPolicies[index]);
          },
        )
        : _getWidgetForNoRecentOrSearchResults();
  }

  Widget? _getRecentSearchList(Function(String) onTap) {
    if (_recentSearch.isEmpty) {
      return null;
    }
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Recent Searches", style: AppTextStyle.titleMediumSemiBold),
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _recentSearch.length,
                itemBuilder: (context, index) {
                  return _getSearchResultCell(_recentSearch[index], onTap);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getSearchResultCell(String searchKey, Function(String) onTap) {
    return InkWell(
      onTap: () => onTap(searchKey),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Row(
          children: [
            Icon(Icons.history),
            SizedBox(width: 15,),
            Text(
              searchKey,
              style: AppTextStyle.bodyMedium.apply(color: AppColor.textTertiary),
            ),
            Spacer(),
            Transform.rotate(angle: 45,
            child: Icon(Icons.arrow_back_outlined)),
          ],
        ),
      ),
    );
  }

  Widget _getWidgetForNoRecentOrSearchResults() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child:
            _searchTextEditingController.text.isNotEmpty
                ? Text("No policy found!")
                : Text(
                  "Start typing a name or policy number to search, or tap the mic to search by voice.",
                  textAlign: TextAlign.center,
                ),
      ),
    );
  }
}
