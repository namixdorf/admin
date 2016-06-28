module CohesiveAdmin
  module ApplicationHelper

    def inverse_relationship_exists?(child, association, parent)
      association = association.to_s
      (parent.reflections.values.include?(child.reflections[association].inverse_of) rescue false)
    end

    def aws_init
      data = false
      unless CohesiveAdmin.config.aws.blank?
        # Froala requires that we provide the region-specific endpoint as the 'region' parameter. We'll use the aws-sdk gem to provide this.
        bucket = Aws::S3::Bucket.new(CohesiveAdmin.config.aws[:bucket], { region: CohesiveAdmin.config.aws[:region] })
        region = bucket.client.config.endpoint.host.gsub(/\.amazonaws\.com\Z/, '')

        data = {
            bucket:         CohesiveAdmin.config.aws[:bucket],
            region:         region,
            key_start:      CohesiveAdmin.config.aws[:key_start],
            acl:            CohesiveAdmin.config.aws[:acl],
            access_key_id:  CohesiveAdmin.config.aws[:access_key_id],
            policy:         CohesiveAdmin::AmazonSignature.policy,
            signature:      CohesiveAdmin::AmazonSignature.signature,
        }
      end

      javascript_tag do
        raw %Q{
          $(function() {
            $(document).trigger('froala.init', [#{data.to_json}]);
          })
        }
      end
    end

  end
end
