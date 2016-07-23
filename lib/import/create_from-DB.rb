# uses DB adapter to load data from a table
# from D. McClure's 'Vacuum' proto-gem

module Import
  class CreateNotices < Step

    def up
      @DB[:master_20150601].distinct(:nid).each do |n|

        Notice.create(
          legacy_id:      n[:nid],
          pub_date:       parse_date(n[:pub_date]),
          notice_date:    parse_date(n[:notification_date]),
          deadline:       parse_date(n[:deadline]),
          url:            clean(n[:url]),
          site_p:         clean(n[:site_p]),
          site_c:         clean(n[:site_c]),
          title_p:        clean(n[:title_p]),
          title_c:        clean(n[:title_c]),
          org_p:          clean(n[:org_p]),
          org_c:          clean(n[:org_c]),
          contact_phone:  clean(n[:contact_phone]),
          contact_p:      clean(n[:contact_p]),
          contact_c:      clean(n[:contact_c]),
        )

        increment

      end
    end

    def down
      Notice.delete_all
    end

    def count
      @DB[:master_20150601].distinct(:nid).count()
    end

  end
end
