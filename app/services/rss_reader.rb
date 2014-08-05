require 'rss'
require 'json'

class RSSReader
  FEED_URL = 'http://www.berlin.de/polizei/polizeimeldungen/index.php/rss'

  def self.perform
    open(FEED_URL) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        ImportWorker.perform_async(item.title, item.link, item.pubDate)
      end
    end
  end

end
