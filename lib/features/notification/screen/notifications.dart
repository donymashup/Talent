import 'package:flutter/material.dart';
import 'package:talent_app/constants/app_constants.dart';
import 'package:talent_app/features/notification/services/notification_services.dart';
import 'package:talent_app/models/notification_model.dart';

class NotificationsPage extends StatelessWidget {
  final NotificationServices _notificationServices = NotificationServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,size: 16, color: Colors.black,),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: AppConstant.backgroundColor,
      ),
      body: Container(
        color: AppConstant.backgroundColor, // Set background color to the screen
        child: FutureBuilder<NotificationModel?>(
          future: _notificationServices.getNotifications(context: context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data?.notifications == null) {
              return Center(child: Text("No notifications available"));
            }
            
            return ListView.builder(
              itemCount: snapshot.data!.notifications!.length,
              itemBuilder: (context, index) {
                final notification = snapshot.data!.notifications![index];
                return Card(
                  color: AppConstant.cardBackground,
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification.title ?? "No Title",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppConstant.titlecolor,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                notification.body ?? "No Content",
                                style: TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              SizedBox(height: 5),
                              Text(
                                notification.created ?? "Unknown Date",
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        if (notification.image != null && notification.image!.isNotEmpty)
                          Container(
                            width: 100,
                            height: 70,
                            margin: EdgeInsets.only(left: 10),
                            child: Image.network(
                              notification.image!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.image_not_supported, color: Colors.grey);
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
