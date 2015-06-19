require "spec_helper"

describe(Store) do
  it { should have_and_belong_to_many(:shoes)}

  it("validates presence of name") do
    new_store = Store.new({:name => ""})
    expect(new_store.save()).to(eq(false))
  end

  it("capitalizes entry when saved") do
    new_store = Store.create({:name => "target"})
    expect(new_store.name()).to(eq("Target"))
  end

end
