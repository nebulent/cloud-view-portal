Given "I have some $models" do |collection|
  model_class = collection.singularize
  @data_collection = 5.times.map { FactoryGirl.create(model_class.to_sym) }
end
