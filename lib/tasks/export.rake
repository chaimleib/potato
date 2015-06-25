namespace :export do
  desc "Prints contents of database in a seeds.rb way."
  
  task :seeds_format => :environment do
    delete_all = proc do
      puts "CodeFreeze.delete_all"
      puts "ResourceUpdate.delete_all"
      puts "User.delete_all"
    end
    
    export_model = proc do |model|
      name = model.name
      model.order(:id).all.each do |item|
        item_hash = item.serializable_hash.
          delete_if{ |key, value|
            [ 'created_at', 
              'updated_at', 
              'id'
            ].include? key
          }.
          to_s.
          gsub(/[{}]/, '')
        puts "#{name}.create(#{item_hash})"
      end
    end
    
    delete_all.call
    export_model.call User
  end
end                    

