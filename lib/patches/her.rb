module Her
  module Model
    module Parse
      module ClassMethods
        def embeded_params(attributes)
          associations.values.flatten.each_with_object({}) do |definition, hash|
            value = case association = attributes[definition[:name]]
                    when Her::Collection #, Array
                      association.map { |a| a.to_params }.reject(&:empty?)
                    when Her::Model
                      association.to_params
                    end
            hash[definition[:data_key]] = value if value.present?
          end
        end
      end
    end
  end
end
