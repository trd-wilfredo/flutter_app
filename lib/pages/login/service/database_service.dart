import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // reference for collection

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("group");
  final CollectionReference csCollection =
      FirebaseFirestore.instance.collection("cs");
  final CollectionReference companyCollection =
      FirebaseFirestore.instance.collection("company");
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection("product");

  // saving user data
  Future updateUserData(String fullname, String email) async {
    return await userCollection.doc(uid).set({
      "fullname": fullname,
      "email": email,
      "groups": [],
      "profilePic": '',
      "uid": uid
    });
  }

  // get user groups
  getUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }

  //get all user
  Future getUserById() async {
    QuerySnapshot snapshot =
        await userCollection.where('uid', isEqualTo: uid).get();
    return snapshot;
  }

  //get all user
  Future getAllUser() async {
    QuerySnapshot snapshot =
        await userCollection.where('timeDeleted', isEqualTo: 'false').get();
    return snapshot;
  }

// soft edit user
  Future editUser(String uid, String fullName, String email, String company,
      String level, String timeEdited, String imgPath) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    var edit = await userDocumentReference
        .update({
          "fullName": fullName,
          "email": email,
          "level": level,
          "company": company,
          "profilePic": imgPath,
          "timeEdited": timeEdited,
        })
        .then((value) => true)
        .catchError((error) => print("Failed to add Edit User: $error"));

    return edit;
  }

  // soft delete user
  Future deleteUser(String uid, String timeDeleted) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    var delete = await userDocumentReference
        .update({
          "timeDeleted": timeDeleted,
        })
        .then((value) => true)
        .catchError((error) => print("Failed to add delete User: $error"));

    return delete;
  }

  //get all product
  Future getAllProduct() async {
    QuerySnapshot snapshot =
        await productCollection.where('timeDeleted', isEqualTo: 'false').get();
    return snapshot;
  }

  //get all user
  Future getProductById(String uid) async {
    QuerySnapshot snapshot =
        await productCollection.where('uid', isEqualTo: uid).get();
    return snapshot;
  }

// soft edit product
  Future editProduct(
      String uid,
      String producName,
      String stocks,
      String company,
      String avilability,
      String timeEdited,
      List imgePaths) async {
    DocumentReference productDocumentReference = productCollection.doc(uid);
    print(imgePaths);
    var edit = await productDocumentReference
        .update({
          "productName": producName,
          "stocks": stocks,
          "avilability": avilability,
          "productImages": imgePaths.map((e) => e.toString()).toList(),
          "companyName": company,
          "timeEdited": timeEdited,
        })
        .then((value) => true)
        .catchError((error) => print("Failed to add Edit User: $error"));

    return edit;
  }

  // soft delete product
  Future deleteProduct(String uid, String timeDeleted) async {
    DocumentReference productDocumentReference = productCollection.doc(uid);
    var delete = await productDocumentReference
        .update({
          "timeDeleted": timeDeleted,
        })
        .then((value) => true)
        .catchError((error) => print("Failed to add delete Product: $error"));

    return delete;
  }

  //get all company
  Future getAllCompany() async {
    QuerySnapshot snapshot =
        await companyCollection.where('timeDeleted', isEqualTo: 'false').get();
    return snapshot;
  }

// soft edit Company
  Future editCompany(String uid, String companyName, String avilability,
      String timeEdited, String companyFiles) async {
    DocumentReference companyDocumentReference = companyCollection.doc(uid);
    var edit = await companyDocumentReference
        .update({
          "avilability": avilability,
          "companyFiles": companyFiles,
          "companyName": companyName,
          "timeEdited": timeEdited,
        })
        .then((value) => true)
        .catchError((error) => print("Failed to add Edit User: $error"));

    return edit;
  }

  // soft delete company
  Future deleteCompany(String uid, String timeDeleted) async {
    DocumentReference companyDocumentReference = companyCollection.doc(uid);
    var delete = await companyDocumentReference
        .update({
          "timeDeleted": timeDeleted,
        })
        .then((value) => true)
        .catchError((error) => print("Failed to add delete Product: $error"));

    return delete;
  }

  // getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  // getting the chats
  getChats(String groupId) async {
    return groupCollection
        .doc(groupId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  Future getGroupAdmin(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }

  // toggling the group join/exit
  Future toggleGroupJoin(
      String groupId, String userName, String groupName) async {
    // doc reference
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);

    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];

    // if user has our groups -> then remove then or also in other part re join
    if (groups.contains("${groupId}_$groupName")) {
      await userDocumentReference.update({
        "groups": FieldValue.arrayRemove(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayRemove(["${uid}_$userName"])
      });
    } else {
      await userDocumentReference.update({
        "groups": FieldValue.arrayUnion(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayUnion(["${uid}_$userName"])
      });
    }
  }

  // function -> bool
  Future<bool> isUserJoined(
      String groupName, String groupId, String userName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();

    List<dynamic> groups = await documentSnapshot['groups'];
    if (groups.contains("${groupId}_$groupName")) {
      return true;
    } else {
      return false;
    }
  }

  // get group members
  getGroupMembers(groupId) async {
    return groupCollection.doc(groupId).snapshots();
  }

  // creating a group
  Future createGroup(String userName, String id, String groupName) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${id}_$userName",
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });
    // update the members
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${uid}_$userName"]),
      "groupId": groupDocumentReference.id,
    });

    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      "groups":
          FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"])
    });
  }

  // search
  searchByName(String groupName) {
    return groupCollection.where("groupName", isEqualTo: groupName).get();
  }

  // saving the userdata
  Future savingUserData(String fullName, String email, String level,
      String company, String imgPath) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "groups": [],
      "level": level,
      "company": company,
      "profilePic": imgPath,
      "timeDeleted": "false",
      "uid": uid,
    });
  }

  // Save Company
  Future addSaveCompany(String companyName, String avilability,
      String timeCreated, String companyFiles) async {
    DocumentReference companyDocumentReference = await companyCollection.add({
      "avilability": avilability,
      "companyFiles": companyFiles,
      "companyName": companyName,
      "timeCreated": timeCreated,
      "timeEdited": '',
      "timeDeleted": "false",
    });
    var company = await companyDocumentReference
        .update({
          "uid": companyDocumentReference.id,
        })
        .then((value) => true)
        .catchError((error) => print("Failed to add Company: $error"));

    if (company == true) {
      return true;
    } else {
      return false;
    }
  }

  // search
  searchByCompany(String companyName) {
    return companyCollection.where("companyName", isEqualTo: companyName).get();
  }

  // Save Product
  Future addSaveProduct(String productName, String companyName, String stocks,
      String avilability, String timeCreated, List imgePaths) async {
    // var product = await

    DocumentReference productDocumentReference = await productCollection.add({
      "productName": productName,
      "stocks": stocks,
      "avilability": avilability,
      "companyName": companyName,
      "timeCreated": timeCreated,
      "productImages": imgePaths.map((e) => e.toString()).toList(),
      "timeEdited": '',
      "timeDeleted": "false",
      "companyId": ''
    });
    var product = await productDocumentReference
        .update({
          "uid": productDocumentReference.id,
        })
        .then((value) => true)
        .catchError((error) => print("Failed to add Company: $error"));

    if (product == true) {
      return true;
    } else {
      return false;
    }
  }

  // send message
  sendMessage(String groupId, Map<String, dynamic> chatMessageData) async {
    groupCollection.doc(groupId).collection("messages").add(chatMessageData);
    groupCollection.doc(groupId).update({
      "recentMessage": chatMessageData['message'],
      "recentMessageSender": chatMessageData['sender'],
      "recentMessageTime": chatMessageData['time'].toString(),
    });
  }

  // send message
  csSendMessage(String groupId, Map<String, dynamic> chatMessageData) async {
    csCollection.doc(groupId).collection("messages").add(chatMessageData);
  }

  Future gettingCompanyInfo(String uid) async {
    QuerySnapshot snapshot =
        await companyCollection.where("uid", isEqualTo: uid).get();
    return snapshot;
  }
}
