require './data_mapper_setup'

class Tag

   include DataMapper::Resource

   property :id,           Serial
   property :name,         String
   has n, :links, through: Resource

  def self.add_tags(string,link)
    string.split(/\s+/).each { |word| link.tags << Tag.create(name: word) }
    link.save
  end
end
