# encoding: utf-8

require 'rubygems'
require 'mechanize'
require 'work_queue'


class ImageScraping
  
  attr_accessor :images, :agent, :work_queue
  
  def initialize thread_min_number = 2, thread_max_number = 4
    @work_queue = WorkQueue.new thread_min_number, thread_max_number
    @images = []
    @agent = Mechanize.new
    @agent.user_agent_alias = 'Mac Safari'
  end
  
  def add_images url
    agent.get(url).images.each{ |image| work_queue.enqueue_b{ images << image.fetch} }
    work_queue.join
    images
  end
  
  def save_images dir_name
    Dir.mkdir dir_name unless Dir.exists? dir_name
    dir = Dir.new dir_name
    Dir.chdir dir.path
    images.each{ |image|  image.save }
    Dir.chdir ".."
    clear_empty_files_in_dir dir
  end
  
  private 
  
  def clear_empty_files_in_dir dir
    dir.entries.each do |file_name|
      file_name = File.join dir.path, file_name
	File.delete file_name if File.file?(file_name) && File.size(file_name) == 0 
    end
  end
  
end
