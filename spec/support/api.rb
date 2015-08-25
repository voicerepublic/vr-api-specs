require 'httparty'

# a helper
module API

  extend self

  def get(resource)
    HTTParty.get(url(resource))
  end

  def post(resource, payload)
    HTTParty.post(url(resource), { :body => payload })
  end

  def put(resource, payload)
    HTTParty.put(url(resource), { :body => payload })
  end

  def delete(resource)
    HTTParty.delete(url(resource))
  end

  private

  def config_path
    @config_path ||= File.expand_path(File.join(%w(.. .. .. config.yml)), __FILE__)
  end

  def env
    @env ||= ENV['SPEC_ENV'] || 'staging'
  end

  def config
    @config ||= YAML.load(File.read(config_path))[env]
  end

  def credentials
    @credentials ||= "user_email=#{config['email']}&user_token=#{config['token']}"
  end

  def endpoint
    @endpoint ||= config['endpoint']
  end

  def url(resource)
    endpoint + resource + (resource.include?('?') ? '&' : '?') + credentials
  end

end
