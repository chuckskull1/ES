output "instance_public_ip" {
  description = "ES can be accessed at below ip on 9200 port, happy searching :)"
  value       = aws_instance.ES_Instance.public_ip
}