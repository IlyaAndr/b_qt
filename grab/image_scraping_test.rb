# encoding: utf-8 

require 'rubygems'
require 'fileutils'

require_relative 'image_scraping'

describe ImageScraping do
  
  it "Download all the images from page" do
    url = "http://kinopoisk.ru/"
    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'
    page_img_count = agent.get(url).images.size
    scraping = ImageScraping.new 
    img_count = scraping.add_images(url).size
    img_count.should eql(page_img_count)
  end
  
  it "Save all images from page to folder" do
    url = "http://kinopoisk.ru/"
    folder_name = "images"
    scraping = ImageScraping.new 
    img_count = scraping.add_images(url).size
    scraping.save_images folder_name
    file_count = Dir.entries(folder_name).count{|name| File.file? File.join(folder_name, name)}
    FileUtils.rm_r folder_name
    img_count.should eql(file_count)
  end
  
end