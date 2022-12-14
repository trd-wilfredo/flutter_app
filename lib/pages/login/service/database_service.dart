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
  Future savingUserData(
      String fullName, String email, String level, String company) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "groups": [],
      "level": level,
      "company": company,
      "profilePic": "",
      "uid": uid,
    });
  }

  // Save Company
  Future<void> addSaveCompany(
      String companyName, String avilability, String timeCreated) async {
    return await companyCollection
        .doc('company')
        .set({
          "avilability": avilability,
          "companyName": companyName,
          "timeCreated": timeCreated,
          "timeEdited": '',
          "timeDeleted": ''
        })
        .then((value) => print("Company Added"))
        .catchError((error) => print("Failed to add Company: $error"));
  }

  // Save Product
  Future<void> addSaveProduct(
      String companyName, String avilability, String timeCreated) async {
    return await companyCollection
        .doc(uid)
        .set({
          "avilability": avilability,
          "companyName": companyName,
          "timeCreated": timeCreated,
          "timeEdited": '',
          "timeDeleted": ''
        })
        .then((value) => print("Company Added"))
        .catchError((error) => print("Failed to add Company: $error"));
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
}
