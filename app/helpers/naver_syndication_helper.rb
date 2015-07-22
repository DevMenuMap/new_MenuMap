module NaverSyndicationHelper
	def naver_atom_feed(options = {}, &block)
    if options[:schema_date]
      options[:schema_date] = options[:schema_date].strftime("%Y-%m-%d") if options[:schema_date].respond_to?(:strftime)
    else
      options[:schema_date] = "2005" # The Atom spec copyright date
    end

    xml = options.delete(:xml) || eval("xml", block.binding)
    xml.instruct!
    if options[:instruct]
      options[:instruct].each do |target,attrs|
        if attrs.respond_to?(:keys)
          xml.instruct!(target, attrs)
        elsif attrs.respond_to?(:each)
          attrs.each { |attr_group| xml.instruct!(target, attr_group) }
        end
      end
    end

    feed_opts = {}
    # feed_opts = {"xml:lang" => options[:language] || "en-US", "xmlns" => 'http://www.w3.org/2005/Atom'}
    feed_opts.merge!(options).reject!{|k,v| !k.to_s.match(/^xml/)}

    xml.feed(feed_opts) do
      xml.id(options[:id] || "tag:#{request.host},#{options[:schema_date]}:#{request.fullpath.split(".")[0]}")
      # xml.link(:rel => 'alternate', :type => 'text/html', :href => options[:root_url] || (request.protocol + request.host_with_port))
      # xml.link(:rel => 'self', :type => 'application/atom+xml', :href => options[:url] || request.url)

      yield ActionView::Helpers::AtomFeedHelper::AtomFeedBuilder.new(xml, self, options)
    end
  end
end