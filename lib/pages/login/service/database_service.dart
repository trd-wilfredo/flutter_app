import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

  //get user
  Future getUserById() async {
    QuerySnapshot snapshot =
        await userCollection.where('uid', isEqualTo: uid).get();
    return snapshot;
  }

  // //get user
  // Future getByIdUser(String sid) async {
  //   QuerySnapshot snapshot =
  //       await userCollection.where('uid', isEqualTo: sid).get();
  //   var tes = snapshot.docs.isNotEmpty ? snapshot.docs : [];
  //   return tes;
  // }

  //get all user
  Future getAllUser(String companyId, String userLevel) async {
    if (userLevel == 'admin') {
      QuerySnapshot snapshot = await userCollection
          .where('timeDeleted', isEqualTo: 'false')
          .where('uid', isNotEqualTo: 'sample')
          .get();
      return snapshot;
    } else {
      QuerySnapshot snapshot = await userCollection
          .where('timeDeleted', isEqualTo: 'false')
          .where('companyId', isEqualTo: companyId)
          .get();
      return snapshot;
    }
  }

// soft edit user
  Future editUser(String uid, String fullName, String email, String company,
      String companyId, String level, String timeEdited, String imgPath) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    var edit = await userDocumentReference
        .update({
          "fullName": fullName,
          "email": email,
          "level": level,
          "company": company,
          "companyId": companyId,
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
  Future getAllProduct(String companyId, String userLevel) async {
    // String level, String company
    if (userLevel == 'admin') {
      QuerySnapshot snapshot = await productCollection
          .where('timeDeleted', isEqualTo: 'false')
          .where('uid', isNotEqualTo: 'sample')
          .get();
      return snapshot;
    } else {
      QuerySnapshot snapshot = await productCollection
          .where('timeDeleted', isEqualTo: 'false')
          .where('companyId', isEqualTo: companyId)
          .get();
      return snapshot;
    }
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
      String companyId,
      String companyName,
      String avilability,
      String timeEdited,
      List imgePaths) async {
    DocumentReference productDocumentReference = productCollection.doc(uid);
    var edit = await productDocumentReference
        .update({
          "productName": producName,
          "stocks": stocks,
          "avilability": avilability,
          "productImages": imgePaths.map((e) => e.toString()).toList(),
          "companyId": companyId,
          "companyName": companyName,
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
    QuerySnapshot snapshot = await companyCollection
        .where('timeDeleted', isEqualTo: 'false')
        .where('uid', isNotEqualTo: 'sample')
        .get();
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
    // groupCollection
    //     .doc(groupId)
    //     .collection("messages")
    //     .where("deleted", isEqualTo: "")
    //     .orderBy("time")
    //     .get()
    //     .then((QuerySnapshot snapshot) {
    //   snapshot.docs.forEach((element) {
    //     print('The result of isNotEqualTo query is: ${element.id}');
    //   });
    // });
    return groupCollection
        .doc(groupId)
        .collection("messages")
        .where("deleted", isEqualTo: "")
        .orderBy("time")
        .snapshots();
  }

  // soft delete Message
  Future deleteMessage(
      String groupId, String messageId, String timeDeleted) async {
    DocumentReference userDocumentReference = groupCollection.doc(groupId);
    var delete = await userDocumentReference
        .collection("messages")
        .doc(messageId)
        .update({
          "deleted": timeDeleted,
        })
        .then((value) => true)
        .catchError((error) => print("Failed to delete Message: $error"));

    return delete;
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

  onResolve(foundURL) {
    return foundURL;
  }

  onReject(error) {
    return 'na';
  }

  Future getMembers(String groupId) async {
    final storage = FirebaseStorage.instance.ref();
    var arr = [];
    QuerySnapshot snapshot =
        await groupCollection.where('groupId', isEqualTo: groupId).get();
    for (var group in snapshot.docs) {
      for (var user in group['members']) {
        var id = user.split('_');
        var link = await storage
            .child('profile/${id[0]}')
            .getDownloadURL()
            .then(onResolve, onError: onReject);
        arr.add(link);
      }
    }
    return arr;
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
  searchByName(String searched, String page) async {
    switch (page) {
      case 'user':
        return await userCollection
            .where("fullName", isEqualTo: searched)
            .where("uid", isNotEqualTo: 'sample')
            .get();
      case 'company':
        return await companyCollection
            .where("companyName", isEqualTo: searched)
            .where("uid", isNotEqualTo: 'sample')
            .get();
      case 'product':
        return await productCollection
            .where("productName", isEqualTo: searched)
            .where("uid", isNotEqualTo: 'sample')
            .get();
      default:
        return await groupCollection
            .where("groupName", isEqualTo: searched)
            .where("uid", isNotEqualTo: 'sample')
            .get();
    }
  }

  // saving the userdata
  Future savingUserData(String fullName, String email, String level,
      String company, String companyId, String imgPath) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "groups": [],
      "level": level,
      "company": company,
      "companyId": companyId,
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
  Future searchByCompany(String companyName) async {
    QuerySnapshot snapshot = await companyCollection
        .where("companyName", isEqualTo: companyName)
        .get();
    if (snapshot.docs.isEmpty) {
      return companyCollection
          .where("companyName", isGreaterThanOrEqualTo: companyName)
          .where("companyName", isLessThan: companyName + 'z')
          .where("companyName", isGreaterThan: companyName)
          .get();
    } else {
      return companyCollection
          .where("companyName", isEqualTo: companyName)
          .get();
    }
  }

  // Save Product
  Future addSaveProduct(
      String productName,
      String companyId,
      String companyName,
      String stocks,
      String avilability,
      String timeCreated,
      List imgePaths) async {
    // var product = await

    DocumentReference productDocumentReference = await productCollection.add({
      "productName": productName,
      "stocks": stocks,
      "avilability": avilability,
      "companyName": companyName,
      "companyId": companyId,
      "timeCreated": timeCreated,
      "productImages": imgePaths.map((e) => e.toString()).toList(),
      "timeEdited": '',
      "timeDeleted": "false",
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
