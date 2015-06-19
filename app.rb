require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @shoes = Shoe.all()
  @stores = Store.all()
  erb(:index)
end

get('/shoes') do
  @shoes = Shoe.all()
  erb(:shoes)
end

get('/stores') do
  @stores = Store.all
  erb(:stores)
end

post("/shoes") do
  brand = params.fetch("brand")
  shoe = Shoe.new({:brand => brand, :id => nil})
  shoe.save()
  @shoes = Shoe.all()
  erb(:shoes)
end

post("/stores") do
  name = params.fetch("name")
  store = Store.new({:name => name, :id => nil})
  store.save()
  @stores = Store.all()
  erb(:stores)
end

get("/shoes/:id") do
  @shoe = Shoe.find(params.fetch("id").to_i())
  @stores = Store.all()
  erb(:shoe_info)
end

get("/stores/:id") do
  @store = Store.find(params.fetch("id").to_i())
  @shoes = Shoe.all()
  erb(:store_info)
end

patch("/shoes/:id") do
  shoe_id = params.fetch("id").to_i()
  @shoe = Shoe.find(shoe_id)
  store_ids = params.fetch("store_ids")
  @shoe.update({:store_ids => store_ids})
  @stores = Store.all()
  erb(:shoe_info)
end

delete("/shoes/:id") do
  @shoe = Shoe.find(params.fetch("id").to_i())
  @shoe.delete()
  @shoes = Shoe.all()
  redirect('/')
end

patch("/stores/:id") do
  store_id = params.fetch("id").to_i()
  @store = Store.find(store_id)
  shoe_ids = params.fetch("shoe_ids")
  @store.update({:shoe_ids => shoe_ids})
  @shoes = Shoe.all()
  erb(:store_info)
end

get("/shoes/:id/edit") do
  @shoe = Shoe.find(params.fetch("id").to_i())
  erb(:shoe_name)
end

patch("/shoes/:id/edit") do
  brand = params.fetch("brand")
  shoe_id = params.fetch("id").to_i()
  @shoe = Shoe.find(shoe_id)
  @shoe.update({:brand => brand})
  @stores = Store.all()
  redirect("/")
end
