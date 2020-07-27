## IaC for Udagram Web application
This project implements deployment of an highly available udagram web app from artifacts stored in s3 using
sam and cloudformation templates.
See [Architectural Diagram](Udagram-AWS-architecture.png)

## How to deploy udagram web app
* Rename `.dist` files and populate env variables necessary for deployments in `scripts/parameters` folder 

* Deploy vpc network infrastructure
```bash
make deploy-networking
```
* Deploy ssh key used in bastion host (optional)
```bash
make deploy-jumpbox-key
```
* Deploy web application infrastructure
```bash
make deploy-web-app
```
* Deploy bastion host for debugging web app instances (optional) 

```bash
make deploy-jumpbox
```

### See working test [link](http://udagram-lb-1512637322.eu-west-2.elb.amazonaws.com/)