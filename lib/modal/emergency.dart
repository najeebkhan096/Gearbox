import 'package:cloud_firestore/cloud_firestore.dart';

class WinchModal {
  final String location;
  final int number;

  WinchModal({required this.location, required this.number});

  // Factory method to create an instance from Firestore data
  factory WinchModal.fromFirestore(Map<String, dynamic> data) {
    return WinchModal(
      location: data['location'] ?? '',
      number: data['number'] ?? 0,
    );
  }

  // Method to convert WinchModal instance to Firestore data
  Map<String, dynamic> toFirestore() {
    return {
      'location': location,
      'number': number,
    };
  }
}

class Emergency {
  final int ambulance;
  final List<WinchModal> winch;
  final int police;

  Emergency({
    required this.ambulance,
    required this.winch,
    required this.police,
  });

  // Factory method to create an Emergency instance with default values
  factory Emergency.defaultEmergency() {
    return Emergency(
      ambulance: 0,
      winch: [], // Empty list for winch
      police: 0,
    );
  }

  // Factory method to create an instance from Firestore data
  factory Emergency.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Convert list of winch data to WinchModal objects
    List<WinchModal> winchList = (data['winch'] as List<dynamic>?)
        ?.map((item) => WinchModal.fromFirestore(item as Map<String, dynamic>))
        .toList() ??
        [];

    return Emergency(
      ambulance: data['ambulance'] ?? 0,
      winch: winchList,
      police: data['police'] ?? 0,
    );
  }

  // Method to convert Emergency instance to Firestore data
  Map<String, dynamic> toFirestore() {
    return {
      'ambulance': ambulance,
      'winch': winch.map((item) => item.toFirestore()).toList(),
      'police': police,
    };
  }

  static Future<Emergency?> fetchEmergencyData() async {
    try {
      CollectionReference emergencyCollection =
      FirebaseFirestore.instance.collection('Emergency');
      QuerySnapshot querySnapshot = await emergencyCollection.limit(1).get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        return Emergency.fromFirestore(documentSnapshot);
      } else {
        print('No documents found in the Emergency collection.');
        return null;
      }
    } catch (e) {
      print('Error fetching emergency data: $e');
      return null;
    }
  }

  @override
  String toString() {
    return 'Emergency(ambulance: $ambulance, winch: $winch, police: $police)';
  }
}
