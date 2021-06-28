require "uppy/s3_multipart"

bucket = Aws::S3::Bucket.new(
  name:              "my-bucket",
  access_key_id:     "...",
  secret_access_key: "...",
  region:            "...",
)

UPPY_S3_MULTIPART_APP = Uppy::S3Multipart::App.new(bucket: bucket)
