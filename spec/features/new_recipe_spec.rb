# In your spec file, for example, spec/views/recipes/new.html.erb_spec.rb

require 'rails_helper'

RSpec.describe 'recipes/new.html.erb', type: :view do
  it 'renders the new recipe form' do
    assign(:recipe, Recipe.new)

    render

    expect(rendered).to have_css('link[rel="stylesheet"][href="app/assets/recipes.css"]') # Update the path if needed
    expect(rendered).to have_selector('.recipe-container h2.header', text: 'Create a New Recipe')
    expect(rendered).to render_template(partial: '_form')
  end
end
