resource "aws_sns_topic" "topic" {
  name = "eks-node-alarm-email"
}

resource "aws_sns_topic_subscription" "email-target" {
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "email"
  endpoint  = var.notification_email
}

