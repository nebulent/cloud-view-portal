class AwsToken < ActiveRecord::Base
  ACTIONS = ["cloudwatch:*", "dynamodb:*", "ec2:*", "elasticmapreduce:*",
             "rds:*", "s3:*", "sdb:*", "sns:*", "sqs:*"]

  attr_accessible :link, :period, :user_id
  belongs_to :users

  validates_presence_of :link, :period

end
