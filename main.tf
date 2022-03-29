# The main.tf file is the entrypoint of terraform
#
# it uses the HCL (Hashicorp Configuration Language) syntax
# which is specified here:
# https://www.terraform.io/docs/configuration/syntax.html
#
# Hashicorp has six different kinds of top level elements
# provider, variable, output, resource, data and local
# I will use all of them now:

# a provider in Terraform is in general an external software
# that gives you access to a set of downstream resources and
# data-objects, that are prefixed with the provider name.
# This is particularly important, as it ensures that on
# `terraform init` being called, the specified providers
# will be installed into the `.terraform` folder.
# Usually you won't have to specify built-in providers like `local`
# but it is still best-practice to do so.
# provider configurations can contain a target compatibility version,
# installation source, credentials and more.
provider "local" {}

# you can define input-variables to the cli
# if they do not have a default value you will be asked for one,
# when you invoke the cli and is not otherwise set
# you can set every value from an environment variable
# prefixed with `TF_VAR_` followed by the actual name
variable "person_to_greet" {
  type        = string
  default     = "world"
  description = "the person to greet in this example"
}

# outputs do work very simlilar to variables, you can set them and they
# will be shown in the standart output by the cli at the end of an 'apply' run.
# This can also be used to emit variables to be set in a module
# https://www.terraform.io/docs/configuration/modules.html

output "hello" {
  value = data.local_file.greetfile.content
}

# The fourth and probably most common type is a resource
# this is a factual resource, on whatever provider you like
# it's state is observable and refreshable from Terraforms own
# state-file

resource "local_file" "greeting" {
  content  = "Hello ${var.person_to_greet}!"
  filename = "${path.module}/hello.txt"
}

# The fifth is the 'data' type
# the data type is in principle just a reference to a resource
# this seems kind of dull in this context, since I might as we
# could just set the output to the resource directly, but with
# this type you can reference resources that are either not managed
# by that particular state or not managed by terraform at all.
# This particular data-source has a 'depends_on' meta-argument set.
# I have set this, so that any changes to the above resource
# will be applied, before this file will get referenced.

data "local_file" "greetfile" {
  filename   = local.greetfile_name
  depends_on = [local_file.greeting]
}

# the sixth and last type is just a local variable
# this might come in handy if you're using one particular very long reference
# a lot of times and do not want to type it constantly
# or you want to use one of the internal functions on a resource
locals {
  greetfile_name = local_file.greeting.filename
}
