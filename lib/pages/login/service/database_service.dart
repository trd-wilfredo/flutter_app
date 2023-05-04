import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // reference for collection

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference chatCollection =
      FirebaseFirestore.instance.collection("chat");
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
      "chats": [],
      "profilePic": '',
      "uid": uid
    });
  }

  // get user chats
  getUserChats() async {
    return userCollection.doc(uid).snapshots();
  }

  //get user
  Future getUserById() async {
    QuerySnapshot snapshot =
        await userCollection.where('uid', isEqualTo: uid).get();
    return snapshot;
  }

  //get add field user
  Future addField(String uid) async {
    DocumentReference updatefields = userCollection.doc(uid);
    await updatefields
        .update({
          "addFriend": [],
          "friendList": [],
          "friendRequest": [],
          "blockContact": [],
        })
        .then((value) => true)
        .catchError((error) => print("Failed to update User: $error"));

    return updatefields;
  }

  seenMessage(
      String seenBy, int timeseen, String messageId, String chatId) async {
    print(seenBy);
    DocumentReference getMessageByID =
        chatCollection.doc(chatId).collection("messages").doc(messageId);

    DocumentSnapshot messageData = await getMessageByID.get();

    // Message seen in chat page
    if (messageData['timeseen'] == '') {
      DocumentReference msgDocRefTime = chatCollection.doc(chatId);
      await msgDocRefTime.collection("messages").doc(messageId).update({
        "timeseen": timeseen,
      });
    }
    if (!messageData['seenBy'].contains(seenBy)) {
      List ids = messageData['seenBy'];
      ids.add(seenBy);
      DocumentReference msgDocRefSeenBY = chatCollection.doc(chatId);
      await msgDocRefSeenBY.collection("messages").doc(messageId).update({
        "seenBy": ids,
      });
    }

    // Massage seen Chat List
    DocumentReference getChatByID = chatCollection.doc(chatId);
    DocumentSnapshot chatData = await getChatByID.get();
    if (!chatData['seenBy'].contains(seenBy)) {
      List idsInChat = chatData['seenBy'];
      idsInChat.add(seenBy);
      DocumentReference cahtDocRef = chatCollection.doc(chatId);
      await cahtDocRef.update({
        "seenBy": idsInChat,
      });
    }
    return true;
  }

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
  getChats(String chatId) async {
    return chatCollection
        .doc(chatId)
        .collection("messages")
        .where("deleted", isEqualTo: "")
        .orderBy("time")
        .snapshots();
  }

  // soft delete Message
  Future deleteMessage(
      String chatId, String messageId, String timeDeleted) async {
    DocumentReference chatDocumentReference = chatCollection.doc(chatId);
    var delete = await chatDocumentReference
        .collection("messages")
        .doc(messageId)
        .update({
          "deleted": timeDeleted,
        })
        .then((value) => true)
        .catchError((error) => print("Failed to delete Message: $error"));

    return delete;
  }

  Future getChatAdmin(String chatId) async {
    DocumentReference d = chatCollection.doc(chatId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }

  // toggling the chat join/exit
  Future toggleChatJoin(String chatId, String userName, String chatName) async {
    // doc reference
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference chatDocumentReference = chatCollection.doc(chatId);

    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> chats = await documentSnapshot['chats'];

    // if user has our chats -> then remove then or also in other part re join
    if (chats.contains("${chatId}_$chatName")) {
      await userDocumentReference.update({
        "chats": FieldValue.arrayRemove(["${chatId}_$chatName"])
      });
      await chatDocumentReference.update({
        "members": FieldValue.arrayRemove(["${uid}_$userName"])
      });
    } else {
      await userDocumentReference.update({
        "chats": FieldValue.arrayUnion(["${chatId}_$chatName"])
      });
      await chatDocumentReference.update({
        "members": FieldValue.arrayUnion(["${uid}_$userName"])
      });
    }
  }

  // function -> bool
  Future<bool> isUserJoined(
      String chatName, String chatId, String userName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();

    List<dynamic> chats = await documentSnapshot['chats'];
    if (chats.contains("${chatId}_$chatName")) {
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

  Future getMembersdata(String chatId) async {
    var users = {};
    QuerySnapshot snapshot =
        await chatCollection.where('chatId', isEqualTo: chatId).get();
    for (var chat in snapshot.docs) {
      for (var user in chat['members']) {
        var id = user.split('_');
        users[id[0]] = id[1];
      }
    }
    return users;
  }

  getChatData(String chatId, myid) async {
    // Massage seen Chat List
    DocumentReference getChatByID = chatCollection.doc(chatId);
    DocumentSnapshot chatData = await getChatByID.get();
    if (chatData['seenBy'].contains(myid)) {
      return true;
    }
    return false;
  }

  Future getMembers(String chatId) async {
    final storage = FirebaseStorage.instance.ref();
    var arr = [];
    QuerySnapshot snapshot =
        await chatCollection.where('chatId', isEqualTo: chatId).get();
    for (var chat in snapshot.docs) {
      for (var user in chat['members']) {
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

  // get chat members
  getChatMembers(chatId) async {
    return chatCollection.doc(chatId).snapshots();
  }

  // Direct Message
  Future directMessage(String userName, String id, String chatName) async {
    DocumentReference chatDocumentReference = await chatCollection.add({
      "chatName": "",
      "chatIcon": "",
      "admin": "",
      "members": [],
      "chatId": "",
      "recentMessage": "",
      "recentMessageSender": "",
      "recentMessageTime": ""
    });
    // update the members
    await chatDocumentReference.update({
      "members": FieldValue.arrayUnion(["${uid}_$userName"]),
      "chatId": chatDocumentReference.id,
    });
  }

  // creating a chat
  Future createChat(String userName, String id, String chatName,
      String userDMID, String chatedName) async {
    var admin = "${id}_$userName";
    var chtN = chatName;
    var members = [];
    if (chatName == '*98!1DMChat') {
      admin = "";
      chtN = "";
      members = ['${id}_$userName"', '${userDMID}_$chatedName"'];
    }
    DocumentReference chatDocumentReference = await chatCollection.add({
      "chatName": chtN,
      "chatIcon": "",
      "admin": admin,
      "members": members,
      "chatId": "",
    });
    // if DM
    if (chatName == '*98!1DMChat') {
      await chatDocumentReference.update({
        "chatId": chatDocumentReference.id,
      });
      DocumentReference userDocumentReference = userCollection.doc(uid);
      await userDocumentReference.update({
        "chats":
            FieldValue.arrayUnion(["dm_${chatDocumentReference.id}_$userDMID"])
      });
      DocumentReference userDMDocumentReference = userCollection.doc(userDMID);
      await userDMDocumentReference.update({
        "chats": FieldValue.arrayUnion(["dm_${chatDocumentReference.id}_$uid"])
      });
      return chatDocumentReference.id;
    } else {
      // update the members
      await chatDocumentReference.update({
        "members": FieldValue.arrayUnion(["${uid}_$userName"]),
        "chatId": chatDocumentReference.id,
      });
      DocumentReference userDocumentReference = userCollection.doc(uid);
      return await userDocumentReference.update({
        "chats":
            FieldValue.arrayUnion(["${chatDocumentReference.id}_$chatName"])
      });
    }
  }

  // search
  searchByName(String searched, String page) async {
    switch (page) {
      case 'user':
        return {
          'data': await userCollection
              .where("fullName", isEqualTo: searched)
              .where("uid", isNotEqualTo: 'sample')
              .get()
        };

      case 'company':
        return {
          'data': await companyCollection
              .where("companyName", isEqualTo: searched)
              .where("uid", isNotEqualTo: 'sample')
              .get()
        };
      case 'product':
        return {
          'data': await productCollection
              .where("productName", isEqualTo: searched)
              .where("uid", isNotEqualTo: 'sample')
              .get()
        };
      default:
        return {
          'data': await chatCollection
              .where("chatName", isEqualTo: searched)
              .where("chatId", isNotEqualTo: 'sample')
              .get()
        };
    }
  }

  unfriend(String id, String yourId) {
    return [''];
  }

  Future accecptRequest(String hisId, String yourId) async {
    QuerySnapshot snapshot =
        await userCollection.where('uid', isEqualTo: yourId).get();
    var frndlst = snapshot.docs.first['friendList'] as List;
    if (!frndlst.contains(hisId)) {
      frndlst.add(hisId);
    }
    DocumentReference userDocumentReference = userCollection.doc(yourId);
    var accept = await userDocumentReference
        .update({"friendList": frndlst})
        .then((value) => true)
        .catchError((error) => print("Failed to accept friend: $error"));
    // his Friend request

    QuerySnapshot hisfrndlist =
        await userCollection.where('uid', isEqualTo: hisId).get();
    var hisfl = hisfrndlist.docs.first['friendList'] as List;
    var hisAddfrn = hisfrndlist.docs.first['addFriend'] as List;

    if (hisAddfrn.contains(yourId)) {
      hisAddfrn.remove(yourId);
    }
    if (!hisfl.contains(yourId)) {
      hisfl.add(yourId);
    }
    DocumentReference userFLDocumentReference = userCollection.doc(hisId);
    await userFLDocumentReference
        .update({"addFriend": hisAddfrn, "friendList": hisfl})
        .then((value) => true)
        .catchError((error) => print("Failed to accept friend: $error"));
    return accept;
  }

  Future cancelRequest(String hisId, String yourId) async {
    QuerySnapshot snapshot =
        await userCollection.where('uid', isEqualTo: yourId).get();
    var cancelFr = snapshot.docs.first['addFriend'] as List;
    if (cancelFr.contains(hisId)) {
      cancelFr.remove(hisId);
    }
    DocumentReference userDocumentReference = userCollection.doc(yourId);
    var cancel = await userDocumentReference
        .update({"addFriend": cancelFr})
        .then((value) => true)
        .catchError((error) => print("Failed to add friend: $error"));
    // his Friend request
    QuerySnapshot friendRequested =
        await userCollection.where('uid', isEqualTo: hisId).get();
    var fr = friendRequested.docs.first['friendRequest'] as List;
    if (fr.contains(yourId)) {
      fr.remove(yourId);
    }
    DocumentReference userFRDocumentReference = userCollection.doc(hisId);
    await userFRDocumentReference
        .update({"friendRequest": fr})
        .then((value) => true)
        .catchError((error) => print("Failed to add friend: $error"));
    return cancel;
  }

  Future addFriend(String hisId, String yourId) async {
    // your addFriend request
    QuerySnapshot snapshot =
        await userCollection.where('uid', isEqualTo: yourId).get();
    var addFriend = snapshot.docs.first['addFriend'] as List;
    if (!addFriend.contains(hisId)) {
      addFriend.add(hisId);
    }
    DocumentReference userDocumentReference = userCollection.doc(yourId);
    var add = await userDocumentReference
        .update({"addFriend": addFriend})
        .then((value) => true)
        .catchError((error) => print("Failed to add friend: $error"));

    // his Friend request
    QuerySnapshot friendRequested =
        await userCollection.where('uid', isEqualTo: hisId).get();
    var fr = friendRequested.docs.first['friendRequest'] as List;
    print(yourId);
    if (!fr.contains(yourId)) {
      fr.add(yourId);
    }
    DocumentReference userFRDocumentReference = userCollection.doc(hisId);
    await userFRDocumentReference
        .update({"friendRequest": fr})
        .then((value) => true)
        .catchError((error) => print("Failed to add friend: $error"));
    return add;
  }

  // saving the userdata
  Future savingUserData(String fullName, String email, String level,
      String company, String companyId, String imgPath) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "chats": [],
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
  sendMessage(String chatId, Map<String, dynamic> chatMessageData) async {
    chatCollection.doc(chatId).collection("messages").add(chatMessageData);
    chatCollection.doc(chatId).update({
      "seenBy": [],
      "recentMessage": chatMessageData['message'],
      "recentMessageSender": chatMessageData['sender'],
      "recentMessageTime": chatMessageData['time'].toString(),
    });
  }

  // send message
  csSendMessage(String chatId, Map<String, dynamic> chatMessageData) async {
    csCollection.doc(chatId).collection("messages").add(chatMessageData);
  }

  Future gettingCompanyInfo(String uid) async {
    QuerySnapshot snapshot =
        await companyCollection.where("uid", isEqualTo: uid).get();
    return snapshot;
  }
}
