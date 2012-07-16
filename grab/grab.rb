# encoding: utf-8 

require_relative 'image_scraping'

url = ARGV[0] || "http://kinopoisk.ru/"
folder_name = ARGV[1] || "images"

scraping = ImageScraping.new 

scraping.add_images url
scraping.save_images folder_name 
