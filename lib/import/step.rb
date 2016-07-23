
require 'unicode'

module Import
  class Step < Vacuum::Step

    #
    # Cache a database connection.
    #
    def initialize
      super
      @DB = self.class.DB
    end

    #
    # Connect to the legacy database.
    #
    # @return [Sequel::Database]
    #
    def self.DB

      # Read legacy params from Rails config.
      params = Rails.configuration.database_configuration["legacy"]

      Sequel.connect(
        :adapter => "postgres",
        **params.symbolize_keys
      )

    end

    #
    # Open a CSV in the /data directory.
    #
    # @param file [String]
    #
    def csv(file)
      CSV.open(
        Rails.root.join("data/#{file}"),
        :headers => true,
        :header_converters => :symbol
      )
    end

    #
    # Open a shapefile in the /data directory.
    #
    # @param file [String]
    #
    def shapefile(file)
      path = Rails.root.join("data/#{file}").to_s
      RGeo::Shapefile::Reader.open(path)
    end

    #
    # Cast a geometry to EPSG:4326.
    #
    # @param geometry [RGeo::Geos]
    #
    def to_4326(geometry)
      RGeo::Feature.cast(
        geometry,
        factory: Helpers::Geo.factory,
        project: true,
      )
    end

  end
end
