import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matchsticks/style/app_style.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppStyle.cardsColor[doc['color_id']],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doc["note_title"],
            overflow: TextOverflow.ellipsis,
            style: AppStyle.mainTitle,
          ),
          const SizedBox(height: 4.0),
          Text(
            doc["creation_date_str"],
            style: AppStyle.mainTitle,
          ),
          const SizedBox(height: 8.0),
          Text(
            doc["note_content"],
            style: AppStyle.mainContent,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}
