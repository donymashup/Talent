import 'package:flutter/material.dart';
import 'package:talent_app/constants/app_constants.dart';
import 'package:talent_app/features/chat_gpt/chatGpt.dart';

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: AppConstant.cardBackground,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              readOnly: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatGptScreen(),
                ),
              );
            },
              decoration: InputDecoration(
                hintText: "Ask anything here...",
                hintStyle: TextStyle(color: AppConstant.hindColor),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 12), // Adjust for consistent height
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.all(8.0), // Add padding for alignment
                  child: Image.asset(
                    'assets/icons/search.png',
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
              onChanged: (value) {
                // Handle search input changes
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0), 
            child: Image.asset(
              'assets/icons/aigpt_icon.png',
              height: 34,
              width: 34,
            ),
          ),
        ],
      ),
    );
  }
}
