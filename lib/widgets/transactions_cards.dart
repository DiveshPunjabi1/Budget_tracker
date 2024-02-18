import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_project/utils/icons_list.dart';

import 'transaction_card.dart';

class TransactionsCard extends StatelessWidget {
  TransactionsCard({super.key});

// ignore_for_file:prefer_const_literals_to_create_immutables
  // var appIcons = AppIcons();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          // Padding(
          //     padding: const EdgeInsets.all(15),
          Row(
            children: [
              Text(
                "Recent Transactions",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              )
            ],
          ),
          RecentTransactionsList()
          // ),
        ],
      ),
    );
  }
}

class RecentTransactionsList extends StatelessWidget {
  RecentTransactionsList({
    super.key,
  });
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection("transactions")
            .orderBy('timestamp',descending:true)
            .limit(20)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No transactions found'));
          }
          var data = snapshot.data!.docs;
          return ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var cardData = data[index];
                return TransactionCard(
                  data: cardData,
                );
              });
        });
  }
}

// class TransactionCard extends StatelessWidget {
//   TransactionCard({
//     super.key, required this.data,
//   });
//   final dynamic data;
//   var appIcons = AppIcons();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Container(
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                   offset: Offset(0, 10),
//                   color: Colors.grey.withOpacity(0.09),
//                   blurRadius: 10.0,
//                   spreadRadius: 4.0)
//             ]),
//         child: ListTile(
//           minVerticalPadding: 10,
//           contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//           leading: Container(
//             width: 70,
//             height: 100,
//             child: Container(
//               width: 30,
//               height: 30,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: Colors.green.withOpacity(0.2)),
//               child: Center(
//                   child: FaIcon(appIcons.getExpenseCategoryIcons('home'))),
//             ),
//           ),
//           title: Row(
//             children: [
//               Expanded(child: Text("Car Rent Oct 2023")),
//               Text(
//                 "₹ 8000",
//                 style: TextStyle(color: Colors.green),
//               )
//             ],
//           ),
//           subtitle: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     "Balance",
//                     style: TextStyle(color: Colors.grey, fontSize: 13),
//                   ),
//                   Spacer(),
//                   Text(
//                     "₹ 525",
//                     style: TextStyle(color: Colors.grey, fontSize: 13),
//                   )
//                 ],
//               ),
//               Text(
//                 "25 oct 4:51 PM",
//                 style: TextStyle(color: Colors.grey),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
