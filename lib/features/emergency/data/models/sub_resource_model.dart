import 'package:family_guard/features/emergency/domain/entities/sub_resource_uris_entity.dart';

class SubResourceModel extends SubresourceUrisEntity {
  SubResourceModel(
      {feedback,
      userDefinedMessages,
      notifications,
      recordings,
      streams,
      payments,
      userDefinedMessageSubscriptions,
      siprec,
      events,
      feedbackSummaries})
      : super(
            feedback,
            userDefinedMessages,
            notifications,
            recordings,
            streams,
            payments,
            userDefinedMessageSubscriptions,
            siprec,
            events,
            feedbackSummaries);

  factory SubResourceModel.fromJson(Map<String, dynamic> json) {
    return SubResourceModel(
      feedback: json['feedback'],
      userDefinedMessages: json['user_defined_messages'],
      notifications: json['notifications'],
      recordings: json['recordings'],
      streams: json['streams'],
      payments: json['payments'],
      userDefinedMessageSubscriptions:
          json['user_defined_message_subscriptions'],
      siprec: json['siprec'],
      events: json['events'],
      feedbackSummaries: json['feedback_summaries'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'feedback': feedback,
      'user_defined_messages': userDefinedMessages,
      'notifications': notifications,
      'recordings': recordings,
      'streams': streams,
      'payments': payments,
      'user_defined_message_subscriptions': userDefinedMessageSubscriptions,
      'siprec': siprec,
      'events': events,
      'feedback_summaries': feedbackSummaries,
    };
  }
}
