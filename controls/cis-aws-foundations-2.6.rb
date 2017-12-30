control "cis-aws-foundations-2.6" do
  title "Ensure S3 bucket access logging is enabled on the CloudTrail S3 bucket"
  desc  "S3 Bucket Access Logging generates a log that contains access records
for each request made to your S3 bucket. An access log record contains details
about the request, such as the request type, the resources specified in the
request worked, and the time and date the request was processed. It is
recommended that bucket access logging be enabled on the CloudTrail S3 bucket."
  impact 0.5
  tag "rationale": "By enabling S3 bucket logging on target S3 buckets, it is
possible to capture all events which may affect objects within an target
buckets. Configuring logs to be placed in a separate bucket allows access to
log information which can be useful in security and incident response
workflows."
  tag "cis_impact": ""
  tag "cis_rid": "2.6"
  tag "cis_level": 1
  tag "cis_control_number": ""
  tag "nist": ""
  tag "cce_id": "CCE-78918-0"
  tag "check": "Perform the following ensure the CloudTrail S3 bucket has
access logging is enabled:

'Via the management Console

* Go to the Amazon CloudTrail console at
https://console.aws.amazon.com/cloudtrail/home
[https://console.aws.amazon.com/cloudtrail/home]
* In the API activity history pane on the left, click Trails
* In the Trails pane, note the bucket names in the S3 bucket column
* Sign in to the AWS Management Console and open the S3 console at
https://console.aws.amazon.com/s3 [https://console.aws.amazon.com/s3].
* Under All Buckets click on a target S3 bucket
* Click on Properties in the top right of the console
* Under Bucket:_<bucket_name>_ click on Logging
* Ensure Enabled is checked.

'Via CLI

'aws s3api get-bucket-logging --bucket <s3_bucket_for_cloudtrail>"
  tag "fix": "Perform the following to enable S3 bucket logging:

'Via the Management Console

* Sign in to the AWS Management Console and open the S3 console at
https://console.aws.amazon.com/s3 [https://console.aws.amazon.com/s3].
* Under All Buckets click on the target S3 bucket
* Click on Properties in the top right of the console
* Under Bucket:<s3_bucket_for_cloudtrail> click on Logging

* Configure bucket logging

* Click on Enabled checkbox
* Select Target Bucket from list
* Enter a Target Prefix


* Click Save"
end