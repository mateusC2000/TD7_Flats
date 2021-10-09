require 'rails_helper'

describe 'Visitor log in' do
  context 'as property owner' do
    it 'successfully' do
      teu = PropertyOwner.create!(email: 'teu@shelby.com.br', password: '123456789')

      visit root_path
      click_on 'Entrar'
      fill_in 'Email', with: teu.email
      fill_in 'Senha', with: teu.password
      within 'form' do
        click_on 'Entrar'
      end

      expect(page).to have_content('Login efetuado com sucesso!')
      expect(page).to have_content(teu.email)
      expect(page).to have_link('Logout')
      expect(page).not_to have_link('Entrar')
      expect(page).to have_link('Cadastrar Propriedade')
    end

    it 'and logs out' do
      teu = PropertyOwner.create!(email: 'teu@shelby.com.br', password: '123456789')

      login_as teu, scope: :property_owner
      visit root_path
      click_on 'Logout'

      expect(page).to have_content('Saiu com sucesso')
      expect(page).to_not have_content(teu.email)
      expect(page).to_not have_link('Logout')
      expect(page).to have_link('Entrar')
      expect(page).to_not have_link('Cadastrar Imóvel')
    end
  end

  # context 'as user' do
  #   it 'successfully' do
  #     user = User.create!(email: 'jane@doe.com.br', password: '1234567')

  #     visit root_path
  #     click_on 'Entrar'
  #     fill_in 'Email', with: user.email
  #     fill_in 'Senha', with: user.password
  #     within 'form' do
  #       click_on 'Entrar'
  #     end

  #     expect(page).to have_content('Login efetuado com sucesso!')
  #     expect(page).to have_content(user.email)
  #     expect(page).to have_link('Logout')
  #     expect(page).not_to have_link('Entrar')
  #     expect(page).not_to have_link('Cadastrar Propriedade')
  #   end
  # end
end
