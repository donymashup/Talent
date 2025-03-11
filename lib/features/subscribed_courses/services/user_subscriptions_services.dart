import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talent_app/constants/config.dart';
import 'package:talent_app/constants/utils.dart';
import 'package:talent_app/models/chapter_list_model.dart';
import 'package:talent_app/models/classs_list_model.dart';
import 'package:talent_app/models/common_model.dart';
import 'package:talent_app/models/material_model.dart';
import 'package:talent_app/models/practice_test_model.dart';
import 'package:talent_app/models/subject_list_model.dart';
import 'package:talent_app/models/user_subscriptions_model.dart';
import 'package:talent_app/models/video_model.dart';

class UserSubscriptionsServices {
  Future<UserSubscriptionsModel?> getUserSubscriptions({
    required BuildContext context,
  }) async {
    String? userId = await _getUserId();
    return _fetchData<UserSubscriptionsModel>(
      context: context,
      url: '$baseUrl$userSubscriptions',
      fields: {'userid': userId!},
      fromJson: (json) => UserSubscriptionsModel.fromJson(json),
      successMessage: 'User subscriptions fetched successfully',
      failureMessage: 'Failed to fetch user subscriptions',
    );
  }

  Future<ClassListModel?> getClassList({
    required BuildContext context,
    required String courseId,
  }) async {
    return _fetchData<ClassListModel>(
      context: context,
      url: '$baseUrl$classList',
      fields: {'courseid': courseId},
      fromJson: (json) => ClassListModel.fromJson(json),
      successMessage: 'Class list fetched successfully',
      failureMessage: 'Failed to fetch class list',
    );
  }

  Future<SubjectListModel?> getCourseSubjectList({
    required BuildContext context,
    required String classId,
    required String packageId,
    required String batchId,
  }) async {
    return _fetchData<SubjectListModel>(
      context: context,
      url: '$baseUrl$subjectList',
      fields: {
        'classid': classId,
        'batchid': batchId,
        'packageid': packageId,
      },
      fromJson: (json) => SubjectListModel.fromJson(json),
      successMessage: 'Subject list fetched successfully',
      failureMessage: 'Failed to fetch subject list',
    );
  }

  Future<ChapterListModel?> getSubjectChapterList({
    required BuildContext context,
    required String classId,
    required String subjectId,
    required String packageId,
    required String batchId,
  }) async {
    String? userId = await _getUserId();
    return _fetchData<ChapterListModel>(
      context: context,
      url: '$baseUrl$chapterList',
      fields: {
        'classid': classId,
        'batchid': batchId,
        'packageid': packageId,
        'subjectid': subjectId,
        'userid': userId!,
      },
      fromJson: (json) => ChapterListModel.fromJson(json),
      successMessage: 'Chapter list fetched successfully',
      failureMessage: 'Failed to fetch chapter list',
    );
  }

  Future<VideoModel?> getChapterVideos({
    required BuildContext context,
    required String chapterId,
    required String batchId,
    required String packageId,
  }) async {
    String? userId = await _getUserId();
    return _fetchData<VideoModel>(
      context: context,
      url: '$baseUrl$videoList',
      fields: {
        'chapterid': chapterId,
        'batchid': batchId,
        'packageid': packageId,
        'userid': userId!,
      },
      fromJson: (json) => VideoModel.fromJson(json),
      successMessage: 'Video list fetched successfully',
      failureMessage: 'Failed to fetch video list',
    );
  }

  Future<MaterialsModel?> getChapterMaterials({
    required BuildContext context,
    required String chapterId,
    required String batchId,
    required String packageId,
  }) async {
    String? userId = await _getUserId();
    return _fetchData<MaterialsModel>(
      context: context,
      url: '$baseUrl$materialList',
      fields: {
        'chapterid': chapterId,
        'batchid': batchId,
        'packageid': packageId,
        'userid': userId!,
      },
      fromJson: (json) => MaterialsModel.fromJson(json),
      successMessage: 'Materials list fetched successfully',
      failureMessage: 'Failed to fetch materials list',
    );
  }

  Future<PracticeTestModel?> getChapterPracticeTests({
    required BuildContext context,
    required String chapterId,
    required String batchId,
    required String packageId,
  }) async {
    String? userId = await _getUserId();
    return _fetchData<PracticeTestModel>(
      context: context,
      url: '$baseUrl$practiceTestList',
      fields: {
        'chapterid': chapterId,
        'batchid': batchId,
        'packageid': packageId,
        'userid': userId!,
      },
      fromJson: (json) => PracticeTestModel.fromJson(json),
      successMessage: 'Practice test list fetched successfully',
      failureMessage: 'Failed to fetch practice test list',
    );
  }

  Future<void> insertTimelineActivity({
    required String userId,
    required String contentId,
    required String type,
  }) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseUrl$insertTimelineActivityUrl'));
      request.fields.addAll({
        'userid': userId,
        'contentid': contentId,
        'type': type,
      });

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print('Timeline activity inserted successfully');
      } else {
        print('Failed to insert timeline activity: ${response.statusCode}');
      }
    } catch (e) {
      print('Error inserting timeline activity: $e');
    }
  }

  Future<CommonModel> createUserCourseReview({
    required String userId,
    required String courseid,
    required String review,
    required String rating,
  }) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseUrl$addCourseRatingUrl'));
      request.fields.addAll({
        'userid': userId,
        'courseid': courseid,
        'review': review,
        'rating': rating,
      });

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseBody);
        return CommonModel.fromJson(jsonResponse);
      } else {
        print('Failed to add course review: ${response.statusCode}');
        throw Exception('Failed to add course review');
      }
    } catch (e) {
      print('Error adding course review: $e');
      throw Exception('Error adding course review');
    }
  }

  Future<T?> _fetchData<T>({
    required BuildContext context,
    required String url,
    required Map<String, String> fields,
    required T Function(Map<String, dynamic>) fromJson,
    required String successMessage,
    required String failureMessage,
  }) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields.addAll(fields);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseBody);
        var model = fromJson(jsonResponse);
       // showSnackbar(context, successMessage);
        return model;
      } else {
        print("Failed to fetch data: ${response.statusCode}");
        showSnackbar(context, failureMessage);
        return null;
      }
    } catch (e) {
      print(e);
      showSnackbar(context, failureMessage);
      return null;
    }
  }

  Future<String?> _getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('userId');
  }

  // TODO: updateCourseStars courseid, rating, review
}
