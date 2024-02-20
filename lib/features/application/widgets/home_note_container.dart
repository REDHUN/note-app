import 'package:firebaseauthclean/features/application/services/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteContainer extends StatelessWidget {
  const NoteContainer(
      {super.key, required this.note, required this.time, required this.title});

  final String time;
  final String? note;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1.0,
            blurRadius: 8.0,
            offset: const Offset(
              0,
              8,
            ),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            title,
            style: GoogleFonts.aBeeZee(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColor.headingText),
          ),
          Text(
            note!,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.aBeeZee(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: AppColor.headingText),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            time.toString(),
            style:
                GoogleFonts.aBeeZee(color: AppColor.headingText, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
