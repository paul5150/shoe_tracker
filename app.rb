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
  @shoe = Shoe.new({:brand => brand, :id => nil})
  @shoes = Shoe.all()
    if @shoe.save()
      redirect back
    else
      erb(:errors)
    end
  end

post("/stores") do
  name = params.fetch("name")
  @store = Store.new({:name => name, :id => nil})
  @stores = Store.all()
    if @store.save()
      redirect back
    else
      erb(:store_error)
    end
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

delete("/stores/:id") do
  @store = Store.find(params.fetch("id").to_i())
  @store.delete()
  @stores = Store.all()
  redirect('/')
end

get("/shoes/:id/edit") do
  @shoe = Shoe.find(params.fetch("id").to_i())
  erb(:shoe_name)
end

patch("/shoes/:id/edit") do
  brand = params.fetch("brand")
  shoe_id = params.fetch("id").to_i()
  @shoe = Shoe.find(shoe_id)
  @stores = Store.all()
    if @shoe.update({:brand => brand})
      redirect("/")
    else
      erb(:errors)
    end
  end

get("/stores/:id/edit") do
  @store = Store.find(params.fetch("id").to_i())
  erb(:store_name)
end

patch("/stores/:id/edit") do
  name = params.fetch("name")
  store_id = params.fetch("id").to_i()
  @store = Store.find(store_id)
  @stores = Store.all()
    if @store.update({:name => name})
      redirect("/")
    else
      erb(:store_error)
    end
  end
