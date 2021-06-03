output "aws_sns_topic_alarm_notification" {
  value = {
    arn  = aws_sns_topic.alarm_notification.arn 
    name = aws_sns_topic.alarm_notification.name
  }
}
