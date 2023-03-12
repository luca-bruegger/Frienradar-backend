# frozen_string_literal: true

module ControllerHelpers
  def s3_client
    Aws::S3::Client.new(stub_responses: true)
  end
end