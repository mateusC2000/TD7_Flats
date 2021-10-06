require 'rails_helper'

describe 'Property Owner authentication' do
  it 'cannot create property without login' do
    post '/properties'

    expect(response).to redirect_to(new_property_owner_session_path)
  end

  it 'cannot open new property form unless authenticated' do
    #get '/properties/new'
    get new_property_path

    expect(response).to redirect_to(new_property_owner_session_path)
  end

  it 'cannot open new property location form unless authenticated.' do
    get new_property_location_path

    expect(response).to redirect_to(new_property_owner_session_path)
  end

  it 'cannot register property location without login' do
    post property_locations_path

    expect(response).to redirect_to(new_property_owner_session_path)
  end

  it 'cannot open new property type form unless authenticated.' do
    get new_property_type_path

    expect(response).to redirect_to(new_property_owner_session_path)
  end

  it 'cannot register property type without login' do
    post property_types_path

    expect(response).to redirect_to(new_property_owner_session_path)
  end
end
