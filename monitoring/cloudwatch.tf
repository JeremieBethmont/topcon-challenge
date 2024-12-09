resource "aws_cloudwatch_metric_alarm" "eks-node" {
  for_each = toset(data.aws_autoscaling_groups.groups.names)

  alarm_name          = "eks-node-check-failed-${each.key}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "This metric monitors ec2 health status"
  alarm_actions       = ["${aws_sns_topic.topic.arn}"]

  dimensions = {
    AutoScalingGroupName = each.key
  }
}
