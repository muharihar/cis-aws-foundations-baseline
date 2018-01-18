AWS_ACCESS_INSTANCE_NAME= attribute(
  'aws_access_instance_name',
  description: 'aws access instance name',
  default: "aws_access_instance_name"
)

AWS_ACCESS_INSTANCE_ROLE= attribute(
  'aws_access_instance_role',
  description: 'aws access instance name',
  default: "aws_access_instance_role"
)

control "cis-aws-foundations-1.21" do
  title "Ensure IAM instance roles are used for AWS resource access from
instances"
  desc  "AWS access from within AWS instances can be done by either encoding
AWS keys into AWS API calls or by assigning the instance to a role which has an
appropriate permissions policy for the required access. 'AWS Access' means
accessing the APIs of AWS in order to access AWS resources or manage AWS
account resources."
  impact 0.7
  tag "rationale": "AWS IAM roles reduce the risks associated with sharing and
rotating credentials that can be used outside of AWS itself. If credentials are
compromised, they can be used from outside of the the AWS account they give
access to. In contrast, in order to leverage role permissions an attacker would
need to gain and maintain access to a specific instance to use the privileges
associated with it.

'Additionally, if credentials are encoded into compiled applications or other
hard to change mechanisms, then they are even more unlikely to be properly
rotated due to service disruption risks. As time goes on, credentials that
cannot be rotated are more likely to be known by an increasing number of
individuals who no longer work for the organization owning the credentials."
  tag "cis_impact": ""
  tag "cis_rid": "1.21"
  tag "cis_level": 2
  tag "cis_control_number": ""
  tag "nist": ""
  tag "cce_id": ""
  tag "check": "Whether an Instance Is Associated With a Role

'For instances that are known to perform AWS actions, ensure that they belong
to an instance role that has the necessary permissions:

* Login to AWS Console (with appropriate permissions to View Identity Access
Management Account Settings)
* Open the EC2 Dashboard and choose 'Instances'
* Click the EC2 instance that performs AWS actions, in the lower pane details
find 'IAM Role'
* If the Role is blank, the instance is not assigned to one.
* If the Role is filled in, it does not mean the instance might not *also* have
credentials encoded on it for some activities.

'Whether an Instance Contains Embedded Credentials

'On the instance that is known to perform AWS actions, audit all scripts and
environment variables to ensure that none of them contain AWS credentials.

'Whether an Instance Application Contains Embedded Credentials

'Applications that run on an instance may also have credentials embedded. This
is a bad practice, but even worse if the source code is stored in a public code
repository such as github. When an application contains credentials can be
determined by eliminating all other sources of credentials and if the
application can still access AWS resources - it likely contains embedded
credentials. Another method is to examine all source code and configuration
files of the application."
  tag "fix": "IAM roles can only be associated at the launch of an instance. To
remediate an instance to add it to a role you must create a new instance.

'If the instance has no external dependencies on it's current private ip or
public addresses are elastic IPs:

* In AWS IAM create a new role. Assign a permissions policy if needed
permissions are already known.
* In the AWS console launch a new instance with identical settings to the
existing instance, and ensure that the newly created role is selected.
* Shutdown both the existing instance and the new instance.
* Detach disks from both instances.
* Attach the existing instance disks to the new instance.
* Boot the new instance and you should have the same machine, but with the
associated role.

'Note: if your environment has dependencies on a dynamically assigned PRIVATE
IP address you can create an AMI from the existing instance, destroy the old
one and then when launching from the AMI, manually assign the previous private
IP address.

'Note: if your environment has dependencies on a dynamically assigned PUBLIC IP
address there is not a way ensure the address is retained and assign an
instance role. Dependencies on dynamically assigned public IP addresses are a
bad practice and, if possible, you may wish to rebuild the instance with a new
elastic IP address and make the investment to remediate affected systems while
assigning the system to a role."

  describe aws_ec2_instance(name: AWS_ACCESS_INSTANCE_NAME) do
    its('roles') { should include AWS_ACCESS_INSTANCE_ROLE }
  end
end


# TEST =  [{"Sid"=>"", "Effect"=>"Allow", "Principal"=>{"Service"=>"ec2.amazonaws.com"}, "Action"=>"sts:AssumeRole"}]
#   describe aws_ec2_instance(name: AWS_ACCESS_INSTANCE_NAME) do
#     its('roles') { should include AWS_ACCESS_INSTANCE_ROLE }
#     its('assume') { should cmp TEST }
#   end


# AWS_ACCESS_INSTANCE_NAME= attribute(
#   'aws_access_instance_name',
#   description: 'aws access instance name',
#   default: "test.alpha"
# )

# AWS_ACCESS_INSTANCE_ROLE= attribute(
#   'aws_access_instance_role',
#   description: 'aws access instance name',
#   default: "aws_access_instance_role"
# )




