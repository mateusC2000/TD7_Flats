require 'rails_helper'

describe 'Visitor log in' do
  context 'as property owner' do
    it 'successfully' do
      teu = create(:property_owner)

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
      teu = create(:property_owner)

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
end
