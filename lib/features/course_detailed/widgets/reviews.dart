import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:talent_app/constants/app_constants.dart';
import 'package:talent_app/models/course_details_model.dart';

class ReviewTab extends StatelessWidget {
  final CourseDetailsModel courseDetailsModel;

  ReviewTab({super.key, required this.courseDetailsModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: AppConstant.cardBackground,
        child: SingleChildScrollView(
          child: _ReviewList(reviews: courseDetailsModel.reviews!),
        ),
      ),
    );
  }
}

class _ReviewList extends StatelessWidget {
  final List<Review> reviews;

  const _ReviewList({Key? key, required this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "No Reviews",
            style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(), // Prevent scrolling inside ListView
      shrinkWrap: true, // Shrink ListView to fit its contents
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(review.image!),
            backgroundColor: Colors.transparent,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(review.name!),
              RatingBarIndicator(
                rating: double.parse(review.rating!),
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 16.0,
              ),
            ],
          ),
          subtitle: Text(review.review!),
        );
      },
    );
  }
}