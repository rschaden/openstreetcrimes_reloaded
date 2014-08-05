require 'nokogiri'
require 'json'

class ImportWorker
  include Sidekiq::Worker

  def perform(title, link, pub_date)
    @title = title
    @link = link
    @pub_date = DateTime.parse(pub_date)

    create_report
  end

  def create_report
    @report = Report.find_or_create_by(title: @title,
                                       link: @link,
                                       content: content,
                                       pub_date: @pub_date)
  end

  private

  def content
    document = Nokogiri::HTML(open(@link))
    document.css('.text .textile p').first.text
  end
end
