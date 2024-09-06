class NotificationModel{
  final String vehicleNumber;
  final String title;
  final String body;
  final String time;

  NotificationModel({required this.vehicleNumber, required this.title, required this.body, required this.time});
  
  factory NotificationModel.fromJson(Map<String,dynamic> json){
    return NotificationModel(vehicleNumber: json["vehicle"]["vehicleNumber"], title: json["title"], body: json["body"],time: json["time"]);
  }
}