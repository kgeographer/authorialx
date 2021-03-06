ActiveAdmin.register Place do
  permit_params :place_id, :prefname, :place_type, :latitude,
    :longitude, :geom_wkt, :geom_wkt_l, :geom_wkt_a, :source

  config.sort_order = 'place_id_desc'
  # config.sort_order = 'prefname'

  index do
    column 'id', :place_id
    column 'prefname', :prefname
    column 'source', :source
    column 'geom_wkt', :geom_wkt
    column 'geom_wkt_l', :geom_wkt_l

    actions
  end

  form do |f|
    f.inputs do
      f.input :place_id, label:"place_id", hint: "Autogenerated, do not enter for new record; edit existing only with EXTREME care"
      f.input :prefname, label: "Preferred name (e.g. common)"
      f.input :geom_wkt, label: "geom_wkt", hint: "Well-Known Text, e.g. POINT(-0.138708 51.50643) <-- (LON LAT) NO COMMA"
    end
    actions
  end

  filter :source
  filter :prefname



end
