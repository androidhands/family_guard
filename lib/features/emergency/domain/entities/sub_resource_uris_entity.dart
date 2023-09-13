
import 'package:equatable/equatable.dart';

class SubresourceUrisEntity extends Equatable {
  String? feedback;
  String? userDefinedMessages;
  String? notifications;
  String? recordings;
  String? streams;
  String? payments;
  String? userDefinedMessageSubscriptions;
  String? siprec;
  String? events;
  String? feedbackSummaries;

  SubresourceUrisEntity(
      this.feedback,
      this.userDefinedMessages,
      this.notifications,
      this.recordings,
      this.streams,
      this.payments,
      this.userDefinedMessageSubscriptions,
      this.siprec,
      this.events,
      this.feedbackSummaries);

 
  
  @override

  List<Object?> get props => [feedback,
      userDefinedMessages,
      notifications,
      recordings,
      streams,
      payments,
      userDefinedMessageSubscriptions,
      siprec,
      events,
      feedbackSummaries];
}
