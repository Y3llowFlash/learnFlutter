import 'package:flutter/material.dart';
import '../models/event_detail.dart';
import '../services/event_service.dart';

class EventScreen extends  StatelessWidget{
  
  const EventScreen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:  AppBar(title: const Text('Event')),
      body: const EventList(),
    );
  }

}


class EventList extends StatefulWidget{
   
  const EventList({super.key});
  @override
  State<EventList> createState() => _EventListState();

}

class _EventListState extends State<EventList>{

  final _service = EventService();

  @override 
  Widget build(BuildContext context){

    return StreamBuilder<List<EventDetail>>(

      stream: _service.streamAll(),  
      builder: (context, snapshot){

        if (snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.red)),
          );
        }

        final items = snapshot.data ?? const <EventDetail>[];
        if (items.isEmpty) {
          return const Center(child: Text('No events yet'));
        }

          return ListView.separated(

            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 0),
            itemBuilder: (context, i) {
               final e = items[i];
               final sub = 'Date: ${e.date}  •  Start: ${e.startTime}  •  End: ${e.endTime}';
               return ListTile(
                  title: Text(e.description),
                  subtitle: Text(sub),
                  trailing: e.isFavorite ? const Icon(Icons.star) : null,
                  onTap: (){
                     // TODO: navigate to detail page if you add one
                  },
               );

            }

        );

      },
    );

  }

}