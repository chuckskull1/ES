resource "aws_cloudwatch_metric_alarm" "elasticsearch-cpu" {
  alarm_name                = "es-cpu-utilization"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors elasticsearch ec2 cpu utilization"
  insufficient_data_actions = []

  dimensions = {
       InstanceId = aws_instance.ES_Instance.id
     }
}


resource "aws_cloudwatch_metric_alarm" "elasticsearch-memory" {
    alarm_name = "es-mem-util-high"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "MemoryUtilization"
    namespace = "AWS/EC2"
    period = "300"
    statistic = "Average"
    threshold = "80"
    alarm_description = "This metric monitors ec2 memory for high utilization on es instance"
    dimensions = {
        InstanceId = aws_instance.ES_Instance.id
    }
}