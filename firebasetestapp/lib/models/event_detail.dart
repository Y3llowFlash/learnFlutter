class EventDetail {

  final String id;
  final String description;
  final String date;
  final String startTime;
  final String endTime; 
  final String speaker;
  final bool isFavorite;

  const EventDetail({
    required this.id,
    required this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.speaker,
    required this.isFavorite
  });

  factory EventDetail.fromMap(Map<String,dynamic> map, String documentId){
    return EventDetail(
      id: documentId,
      description: map['description'] ?? '',
      date: map['date'] ?? '', 
      startTime: map['start_time'] ?? '', 
      endTime: map['end_time'], 
      speaker: map['speaker'], 
      isFavorite: map['is_favorite']?? '');
  }

  Map<String, dynamic> toMap() {

    return{
      'description': description,
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
      'speaker': speaker,
      'is_favorite': isFavorite,
    };
  

  }

}