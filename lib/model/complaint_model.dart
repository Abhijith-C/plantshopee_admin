

class ComplaintModel {
  String complaintId;
  String orderId;
  String userId;
  ComplaintModel({
    required this.complaintId,
    required this.orderId,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'complaintId': complaintId,
      'orderId': orderId,
      'userId': userId,
    };
  }

  static ComplaintModel fromMap(Map<String, dynamic> map) {
    return ComplaintModel(
      complaintId: map['complaintId'] ?? '',
      orderId: map['orderId'] ?? '',
      userId: map['userId'] ?? '',
    );
  }

  
}
