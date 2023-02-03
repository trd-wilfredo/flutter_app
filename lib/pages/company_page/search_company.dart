import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_features/pages/login/service/database_service.dart';
import 'package:flutter_features/pages/company_page/company_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_features/widgets/widget.dart';

class CompanySearch extends StatefulWidget {
 const CompanySearch({super.key});

  @override
  State<CompanySearch> createState() => _CompanySearchState();
}

class _CompanySearchState extends State<CompanySearch> {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  bool hintText = true;
  QuerySnapshot? searchSnapshot;
  bool hasUserSearched = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          hintText = false;
        });
      } else {
        setState(() {
          hintText = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Search Company",
          style: TextStyle(
              fontSize: 27, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    focusNode: focusNode,
                    cursorColor: Colors.white,
                    controller: searchController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hintText ? "Search Company..." : null,
                        hintStyle:
                            const TextStyle(color: Colors.white, fontSize: 16)),
                    onFieldSubmitted: (value) {
                      initiateSearchMethod();
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    initiateSearchMethod();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(40)),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor),
                )
              : companyList(),
        ],
      ),
    );
  }

  initiateSearchMethod() async {
    if (searchController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await DatabaseService()
          .searchByCompany(searchController.text)
          .then((snapshot) {
        setState(() {
          searchSnapshot = snapshot;
          isLoading = false;
          hasUserSearched = true;
        });
      });
    }
  }

  companyList() {  
    return hasUserSearched
    ? ListView.builder(
        shrinkWrap: true,
        itemCount: searchSnapshot!.docs.length,
        itemBuilder: (context, index) {
          return companyTile(     
            searchSnapshot!.docs[index]['uid'],
            searchSnapshot!.docs[index]['companyName'],
          );
        },
      )
    : Container();
  }

  Widget companyTile(
      String uid, String companyName) {
        
    return ListTile(
      
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      trailing: InkWell(
        child: Align(
          alignment: Alignment.center,
          child: Text(
                  companyName, 
                  style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.blueAccent,
                            fontSize: 16,
                            decoration: TextDecoration.underline )),
        ),
        onTap: () async {
          await DatabaseService()
              .gettingCompanyInfo(uid);
          Future.delayed(const Duration(seconds: 0), () {
              nextScreen(
                  context,
                  CompanyInfoPage(
                      uid: uid,
                      companyName: companyName));
            });
        },
      ),
    );
  }
}

