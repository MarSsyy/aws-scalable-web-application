resource "aws_launch_template" "web_lt" {
  name_prefix   = "web-app-lt-"
  image_id      = data.aws_ami.web_ami.id
  instance_type = "t2.micro"
  key_name      = "testKey" 

  iam_instance_profile {
    arn = data.aws_iam_instance_profile.cw_role.arn 
  }

  network_interfaces {
    associate_public_ip_address = false 
    security_groups             = [data.aws_security_group.web_app_sg.id]  
  }

  depends_on = [data.aws_iam_instance_profile.cw_role]

  tags = {
    Name = "asg-web-server"
  }
}


resource "aws_autoscaling_group" "web_asg" {
  name                      = "assignment-1-web-asg"
  max_size                  = 4 
  min_size                  = 2 
  desired_capacity          = 2 
  vpc_zone_identifier       = data.aws_subnets.private.ids  

  target_group_arns         = [data.aws_lb_target_group.web_tg.arn]

  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "asg-member"
    propagate_at_launch = true
  }

  health_check_type         = "ELB"
  health_check_grace_period = 300 
}

resource "aws_autoscaling_policy" "scale_out" {
  name                   = "assignment-1-scale-out-policy"
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300 
  scaling_adjustment     = 1
  
}

resource "aws_autoscaling_policy" "scale_in" {
  name                   = "assignment-1-scale-in-policy"
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300 
  scaling_adjustment     = -1
 
}


resource "aws_cloudwatch_metric_alarm" "high_memory_alarm" {
  alarm_name          = "asg-high-memory-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2 
  metric_name         = "MemoryUsage" 
  namespace           = "Assignment1"   
  period              = 300            
  statistic           = "Average"
  threshold           = 80             
  alarm_actions = [aws_autoscaling_policy.scale_out.arn] 
  
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web_asg.name
  }
  
  
}

resource "aws_cloudwatch_metric_alarm" "low_memory_alarm" {
  alarm_name          = "asg-low-memory-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2 
  metric_name         = "MemoryUsage"
  namespace           = "Assignment1"
  period              = 300
  statistic           = "Average"
  threshold           = 40           
  alarm_actions = [aws_autoscaling_policy.scale_in.arn] 
  
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web_asg.name
  }
  
  
}