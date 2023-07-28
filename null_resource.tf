resource "null_resource" "provisioner" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    always_run = timestamp()
  }
  depends_on = [aws_instance.bastion]

  connection {
    host        = aws_instance.bastion.public_ip
    type        = "ssh"
    user        = "ec2-user"
    private_key = var.mykey
  }

  provisioner "file" {
    # source      = "~/Downloads/new-ultimate-cicd.pem" # where do you want to fetch the file from
    destination = "/home/ec2-user/mykey" # to what destination we want the file to be taken to
    content     = var.mykey
    # even if it fails proceed to the next step
    on_failure = continue
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 mykey"
    ]
  }

}