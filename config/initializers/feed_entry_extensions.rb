module ActionView
	module Helpers
		module AtomFeedHelper
			class AtomFeedBuilder
				def naver_entry(record, options = {})
          @xml.entry do
            @xml.id(options[:id] || "tag:#{@view.request.host},#{@feed_options[:schema_date]}:#{record.class}/#{record.id}")

            # if options[:published] || (record.respond_to?(:created_at) && record.created_at)
            #   @xml.published((options[:published] || record.created_at).xmlschema)
            # end

            # if options[:updated] || (record.respond_to?(:updated_at) && record.updated_at)
            #   @xml.updated((options[:updated] || record.updated_at).xmlschema)
            # end

            type = options.fetch(:type, 'text/html')

            # @xml.link(:rel => 'alternate', :type => type, :href => options[:url] || @view.polymorphic_url(record))

            yield AtomBuilder.new(@xml)
          end
        end
      end
    end
  end
end