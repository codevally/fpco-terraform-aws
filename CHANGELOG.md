
## Changes since v0.5.0

* add this `CHANGELOG.md`
* route-public: drop the inline route in the public route table, module users can now add their own routes to that table
* nomad-server-sg: use distinct() to make the module more flexible, instead of forcing module users to put servers/agents in separate subnets
* update string-list variables from the old days:
    * `nomad-server-sg`: convert worker/server CIDR block variables to lists
    * `nomad-agent-sg`: update `cidr_blocks` variable to a list
    * `consul-leader-wan-sg`: update use of `cidr_blocks`
    * `consul-agent-sg`: update `cidr_blocks` variable to a list
    * `ssh-sg`: update `allowed_cidr_blocks` variable to a list
    * `consul-leader-sg`: update `cidr_blocks` variable to a list
* `tf fmt` and whitespace fixups:
    * `nomad-server-sg`
    * `nomad-agent-sg`
    * `cluster-network`
    * `consul-demo-server`
    * `consul-agent-generic-init`
    * `consul-cluster`
    * `aws-ipsec-vpn`
    * `asg`
    * `bind-server-sg`
    * `consul-leader-wan-sg`
    * `consul-agent-sg`
    * `ssh-sg`
    * `vpc`
    * `persistent-ebs`
    * `packer-vpc`
    * `consul-leader-sg`
    * `packer/terraform-vpc`
* `consul-leader-wan-sg`: bugfix for `wan_port`
* Corrected outputs in the `aws-ipsec-vpn` and `subnets` modules (exposed by TF v0.11.0)
* documentation updates:
    * move credstash into tutorial section
    * create section for tutorials
    * drop placeholder for saltstack docs
* `setup-meta-inf`: allow users to see password policy and change password
* tests: add test scenario for EC2 NAT instance
* `ec2-nat-instance`: fixup init script
* Fixed syntax errors in `consul-leader-wan-sg` (#35)
* .gitignore: add tf.out
* consul-leader-sg: name variable should not have a default
* packer/ubuntu-trusty: fixup description in build.sh
* persistent-ebs: export document from role policy, not profile.
* persistent-ebs: export policy document for other roles.
* A single-node autoscaling group running Nexus (#30)
* logstash: fail hard on CA creation failure.
* credstash-setup: do not assume `credstash` is installed globally.
* Packer/Kubespray: Adds consul binary to AMI
* Packer/Kubespray: Adds AMI description field
* Packer kubespray: Fix vpc part of readme
* kube-*: allow non-prefixed names for backwards compatibility.
* Adds name_prefix as input for kube-{controller,worker}-iam modules
* Moved curator setup snippet into its own module
* ec2-nat-instance: refactor the module for flexibility
* ec2-nat-instance: add `route_table_id` to outputs.
* A single-node autoscaling group running Gitlab
* new modules:
    * `ec2-fixed-ip-auto-recover-instances`
* init-snippet/config-consul-leader: drop "run consul" from config snippet
* ec2-nat-instances: fix bad git merge.
* logstash: `terraform fmt`.
* logstash: increase ASG grace period so smaller instances work.
* logstash: ensure APT sources are up-to-date before provisioning.
* logstash: fix SG creation conflict when CIDRs overlap.
* elasticsearch: ensure nodes have up-to-date APT sources and pip.
* ec2-nat-instance: fix incorrect HTTPS port.
* bind-server: accept multiple zone files as a pre-rendered folder.
* Trimmed the 'single-node-asg' module
* kube-stack: update default cluster size for controllers
7d51dfd kube-stack: rename kube ELB to allow for longer names
d2735f1 new init-snippet module to config upstart to run consul
29491ca init-snippet/install-consul: version bump to 0.9.3
453539c init-snippet/run-consul-server: rename to config-consul-leader
49bf2a1 ELK improvements and fixes:
e5ef07e ec2-nat-instance: merge branch 'ec2-nat-instance'
7840f24 Merge pull request #25 from fpco/elk-alb
472a8cb Merged recent changes from master, fixed conflicts
406d970 ec2-nat-instance: add module
beb8dea Adds missing comma
c0546a7 Packer kubespray: Adds ops tool to base ami
17b1491 Packer kubespray: Adds missing variables
980ef91 Adds "ec2:*" permissions to kube controller IAM role
8a6842c kubernetes: remove entire module, deprecated.
89e5750 logstash: update instructions for users on GovCloud.
b265992 credstash-setup: add `aws_cloud` to generalise `is_govcloud`.
64ac9b2 bind-server: add `aws_cloud` for GovCloud usage.
6abf5b7 elk-stack: `terraform fmt` module.
4f1ade9 elk-stack: remove unneeded data source for AMIs.
b3afeff credstash-setup: `terraform fmt`.
3f2acd0 elk-stack: use `ami-ubuntu` module.
5474e60 elasticsearch: add `is_govcloud` option.
a738d50 credstash-setup: add `is_govcloud` option.
502c0ee bind-server: allow usage of bastion host.
e5b344b open-ingress-sg: bugfix vpc_id reference
bfa5bf2 kube-*-iam: rename to use controller/worker terminology
eab1c77 kube-stack: add support, to assign IAM profiles to kube nodes
9ec2e4d elk-stack: ensure `elasticsearch` works on GovCloud.
a402842 elasticsearch: allow usage on GovCloud.
5280f9c credstash-setup: allow usage on GovCloud.
380ad27 credstash-setup: `fmt` module.
10b0ba8 elk-stack: fix AMIs data source.
eb88ec2 elk-stack: allow passing if environment is on GovCloud.
654d7df elk-stack: add GovCloud Ubuntu AMIs.
9b75f33 bind-server: `terraform fmt`.
308ae3a bind-server: allow bastion access.
e475dc7 Fixes invalid command in readme
9b7a310 Packer kubespray: update readme
51ea5e8 Packer kubespray: Move script out of json
36d1c53 Packer kubespray ami builder: Update docs
d1a1c94 Updates kubespray ami builder
9d25ec7 Fixed logstash elb output and brough back logstash r53 entry
7bac24e Generalize ALB:
a6ad352 Adds kube-iam module
9ecad00 tests/kube-stack-*: worker nodes get "unrestricted ingress" sg
9fbf5f0 add new module: open-ingress-sg
3b4a8a2 open-egress-sg: whitespace fixup
0a07e85 add initial test env for kube-stack module
368db19 add new module: initial kube-stack w/ kubespray
97f97e4 Fixed public/private subnets mixup
23bb263 ami-ubuntu: update `owners` so GovCloud works.
d5118b8 vpc-scenario-*: document initial state.
f392ead vpn-scenario-4: fix outputs and route table association.
c65504d add new module: single port security group (TCP)
1f8ba63 add new module: etcd server security group
9af90e0 add mongo-server TF modules (for security groups)
817ad7c asg: add support for "extra_tags" variable
db1516f add init-snippet-exec module
01ca5ed packer-vpc: add Canonical's owner id for GovCloud AMI lookup
3bd22c5 snapshot-bucket: add `aws_cloud` variable
8f6e0cb dnsmasq-server: add new module
5478b69 packer-vpc: correct ami references in outputs
7d2d3fd vpc-scenario-1: add docs to vpc-scenario-1 module to demo order of operations
dec1cce vpc-scenario-*: update output references in VPC modules to sync with others
f510826 vpc: rename `id` and `cidr_block` outputs to include `vpc_` prefix
aa81d47 vpc-scenario-1: fixup cidr_blocks list in public-subnets
1f2d55b vpc-scenario-4: fixup public flag when using private-subnets module
82e7a81 vpc-scenario-3: fixup public flag when using private-subnets module
399a231 consul-demo-server: set default instance_type to t2.micro
610e359 single-node-asg: whitespace fixup
0099161 add aws_cloud variable/plumbing to consul-demo module + dependents
4dafa38 consul-demo-server: drop extra `load_balancers`
b25418e persistent-ebs: drop extra `extra_tags` variable definition
7410c32 vpc-scenario-3: fixup errors in module
86f928a cross-account-group: whitespace fixup
1d3bde3 setup-meta-infrastructure: whitespace fixup
85898e3 add aws_cloud variable to IAM modules
2380dea s3-remote-state: add aws_cloud variable
3a3d3f2 tests/vpc-scenario-2: add env to test the vpc-scenario-2 module
6822a6a tests/vpc-scenario-1: add env to test the vpc-scenario-1 module
7b5851e vpc-scenario-4: add new module with VPC for AWS Network Scenario 4
5f16a3a vpc-scenario-3: add new module with VPC for AWS Network Scenario 3
b4fc836 vpc-scenario-2: add new module with VPC for AWS Network Scenario 2
72f15a0 vpc-scenario-1: add new module with VPC for AWS Network Scenario 1
1eeabd7 Merge pull request #24 from fpco/deni/packer-kube
010aacf Adds packer for kubespray-base-ami
4b36168 WIP of translating ELB to ALB for ELK:
08f7b6a WIP on moving ELB to ALB for ES and Kibana
6e24e72 Extracted Route53 attachments into separate module for ELK componenets
32fdb44 ELK improvements:
70dfdc1 Improvements to ELK
b591a32 Made master_only optional for curator. Fixed metricbeat process module name
1b861a5 Adjusted collected metrics and added outputs to be used for alerts
39b5510 Consolidated elasticsearch nodes config files into one
24be377 Update elasticsearch config
