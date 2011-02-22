require 'hpricot'
require 'open-uri'
require 'base64'

class InlineImage
  def initialize(app)
    @app = app
  end
  
  def call(env)
    #Status is an integer (200, 400 etc), headers is a string-string hash, and response is an object (response object from rails)
    request = Rack::Request.new(env)
    status, headers, response = @app.call(env)
    doc = Hpricot(response.body)
    debugger
    (doc/"img").each do |img|
      img.attributes['src'] = encodify_image(img.attributes['src'], request.url.match(/\A(http:\/\/|https:\/\/)/)[1] + request.host_with_port)
    end
    [status, headers, doc.to_html]
  end
  
  private
  def encodify_image(image_location, hostname = "")
    #begin
      image_location = hostname + image_location if hostname
      open(image_location) do |file|
        content_type = File.exists?(image_location) ? image_type(image_location) : file.content_type
        return "data:#{content_type};base64,#{Base64.encode64(file.read)}"
      end
    #rescue
    #  return image_location
   # end
  end
  
  private
  
  def image_type(file)
    case IO.read(file, 10)
      when /^GIF8/ then 'gif'
      when /^\x89PNG/ then 'png'
      when /^\xff\xd8\xff\xe0\x00\x10JFIF/ then 'jpg'
      when /^\xff\xd8\xff\xe1(.*){2}Exif/ then 'jpg'
      else 'application/octet-stream'
    end
  end

end
