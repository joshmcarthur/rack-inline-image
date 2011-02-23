RACK INLINE IMAGE
=====================

This Rubygem is an effort at automating the process of reducing requests per page load by selectively embedding images into a page, rather than just *referring* to them in HTML source code using `<img src'...' />`. 

The code itself is framework-agnostic, which means that it should work the same way on every framework Rack supports - including Sinatra, Camping (many others), but most importantly, Ruby on Rails.

Why
====================
A key area where many sites do badly on performance is requests - more specifically, the number of requests required to render a page. As much as possible, content should be embedded into a page to reduce the overall load time that would otherwise be caused by sending a request, waiting for it to be processed and receiving the content.

What
====================
This gem is really a very simple Rack application - it sits between your web server (Apache, Nginx etc.) and your application (Rails, Camping, Sinatra...), intercepting responses from the application and rewriting `<img />` tags to use data embedded within the tag, instead of returning an image location which must then be fetched by the browser in another request. The application supports images from both the local server (i.e. from file), and from another server (i.e. http://example.com/image.jpg).

Installation
====================
If you are using Rails:
* Add `inline_image` to your Gemfile: `gem 'inline_image', :git => 'https://www.github.com/joshmcarthur/rake-inline-image.git'`
* Register the middleware within your Rails application: `config.middleware.use 'InlineImage'`
* That's it!

Usage
===================
All images will be embedded within the page by default - if there is an image, or group of images that should not be embedded, then simply add the class `no-embed` to the image tag.

Advantages
===================
* Embedding images into the image src as encoded data can help with HTTPS mixed-content warnings, as the images all appear to come from a secure source (Well, the page comes from a secure source, and the images are contained within the page).
* Using embedded images can save a bunch of requests from being made. This works especially well with small to medium sized images that are not cacheable, or should not be cached.

Disadvantages
========================
* There is a cost associated with embedding encoded data (See below), but with gzip compression enabled on the server this cost is reduced drastically (down to 102-103% of image file size).
* Embedding images can mess up browser caching, since the image is not a seperate entity from the page. Careful configuration of server caching though can reduce the potential negatives of this so that the static pages are also cached.

Licence
=========================
Unless otherwise specified, all of my work on Github is open-sourced under an MIT License - this is my way of contributing back to the development community.

