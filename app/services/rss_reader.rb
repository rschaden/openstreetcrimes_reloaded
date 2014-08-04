require 'rss'
require 'nokogiri'

class RSSReader
  attr_reader :item
  FEED_URL = 'http://www.berlin.de/polizei/polizeimeldungen/index.php/rss'

  def self.perform
    open(FEED_URL) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        new(item).create_report
      end
    end
  end

  def initialize(item)
    @item = item
  end

  def create_report
    @report = Report.find_or_create_by(title: item.title,
                                       link: item.link,
                                       content: content,
                                       pub_date: item.pubDate)
  end

  private

  def content
    document = Nokogiri::HTML(open(item.link))
    document.css('.text .textile p').first.text
  end
end
