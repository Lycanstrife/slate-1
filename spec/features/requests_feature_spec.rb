require 'spec_helper'

describe 'requests page' do
	context 'no requests' do
		it 'shows a message' do
			visit '/requests'
			expect(page).to have_content 'No requests'
		end
	end

	describe 'adding requests' do
		context '1 valid post' do
			before {
				set_omniauth
				visit '/'
				click_link 'Sign in with Github'
			}
			it 'displays one request' do
				visit '/requests/new'
				fill_in 'Description', with: 'Migration issue'
				fill_in 'Category', with: 'Postgresql'
				click_button 'Create Request'

				expect(current_path).to eq '/requests'
				expect(page).to have_content 'Migration issue'
				expect(page).to have_content 'Postgresql'
			end
		end

		context 'with requests' do
		    before { Request.create(description: 'Help me', category: 'Ruby') }

		    it 'displays the request' do
		      visit '/requests'
		      expect(page).to have_content 'Help me'
		      expect(page).to have_content 'Ruby'
		    end

		    xit 'displays the request time' do
		    	visit '/requests'
		    	expect(page).to have_content Time.now
		    end
		end
	end
end
