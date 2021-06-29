require "uppy/s3_multipart"

settings = Rails.configuration.uppy

bucket = Aws::S3::Bucket.new(
  name:              settings[:s3][:bucket],
  access_key_id:     settings[:s3][:access_key],
  secret_access_key: settings[:s3][:secret_key],
  region:            'us-east-1'
)

UPPY_S3_MULTIPART_APP = Uppy::S3Multipart::App.new(bucket: bucket, prefix: 'tmp', public: true)
