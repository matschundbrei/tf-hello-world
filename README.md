# helloworld-example

In this example you can see how:

- terraform works in its most basic form

- you can use the .gitlab-ci.yaml to run things

## Prerequisites

To test and run this code locally, you might want to install the
[Terraform CLI](https://learn.hashicorp.com/terraform/getting-started/install.html)

You will also need a local copy of the code in this repository. Ideally you would use `git clone` to 
get a local copy of the code. You can get this repositories clone url by clicking on the `clone` button.

Instructions on how to install git, can be found [here](https://dev.sta.net/help/topics/git/how_to_install_git/index.md).

## Files in this repository

### main.tf

This is the entrypoint for any terraform command issued.

### .gitlab-ci.yml

This is the ci/cd pipeline configuration.

### .gitignore

This file defines which files will be ignored by git

### .editorconfig

This file defines how the code is supposed to look like

## Local testing

Once you have cloned the code to a folder, you can start your CLI of choice and navigate to that folder.

Given you have installed terraform and it is in path, you can now run:

```shell
$ terraform init
...
$ terraform plan -out tf.plan
...
$ terraform apply $PLAN
```

## Testing the CI/CD Pipeline

In the [CI/CD Pipelines](https://dev.sta.net/rnd/devops/helloworld-example/pipelines) section of this project, you can manually start a pipeline to run whatever is specified in `.gitlab-ci.yml`.

In this case, it will use terraform to run the terraform-code in this repository.

You can alter who will be greeted by setting the environment variable `TF_VAR_person_to_greet` to any value you would like to greet.

Note, that this will also alter a the `local_file.greeting` resource, which results in a `./hello.txt` that will be cached in between
pipeline stages, but ignored by the repository itself. 

