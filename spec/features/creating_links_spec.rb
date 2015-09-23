require "spec_helper"


feature 'creating links' do

  scenario 'there are no links in the database at the start of the test' do
    expect(Link.count).to eq 0
  end


end
