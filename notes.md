## about packer
- simple examples [packer-digitalocean](https://dev.to/corpcubite/automating-building-images-with-packer-in-digitalocean-56ip)


__WHY WE USE PACKER__

We saw how Terraform could be used to provision an EC2 instance and customize it on first boot by executing a bash script from user data, which is amazing and saves a lot of manual work from the administrator. But consider a scenario where the initial setup used to customize the EC2 instance takes a long time to run to completion. Now suppose this EC2 instance encounters a kernel panic on a particular day, and no amount of reboots will solve it. The instance would have to be destroyed and re-created, which would take a long time before the new instance arrives at a functional state, i.e. whatever services that instance offers would be down for a long time, causing prolonged negative impact to business. Instead of wasting time (automatically) customizing each EC2 instance after it has been created, what if we could customize the EC2 instance up front, save that new state and launch all subsequent instances from that new state? Then, whenever our instance(s) are down for whatever reason, we can re-launch a new instance with everything already set up and running.


Enter Packer. Packer is another offering by HashiCorp that deals with the automated provisioning of customized images, also released under the MPL 2.0. With Packer, we can use a base image and bake our customized setup into it to form a new image, which can then be used to provision EC2 instances with Terraform, such that we only have to run the setup once instead of on every instance launch.

[.....](https://dev.to/donaldsebleung/introduction-to-infrastructure-as-code-with-terraform-and-packer-10cl)
