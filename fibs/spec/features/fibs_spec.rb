require_relative '../rails_helper'

describe 'the fibs feature', :type => :feature do
  before do
    5.times { FactoryGirl.create(:fib) }
  end

  scenario 'allows users to view of list of existing fibs' do
    visit '/fibs'

    expect( page ).to have_content('A Test Fib Sequence', count: 5)
  end

  context 'when creating a new record' do
    before do
      create_fib
    end

    scenario 'allows users view the fib' do
      expect( page ).to have_content('this is a test fib')
    end

    scenario 'allows users to view generated sequence' do
      expect( page ).to have_content('0, 1, 1, 2, 3')
    end
  end

  context 'when editing a fibs record' do
    scenario 'changing sequence length updates stored fibs' do
      visit '/fibs'
      first(:link, 'Edit').click
      fill_in 'fib[sequence_length]', with: '15'
      click_button 'Update Fib'

      expect( page ).to have_content('55, 89, 144, 233, 377')
    end
  end

  scenario 'allows users can delete a fibs record' do
    visit '/fibs'
    first(:link, 'Destroy').click

    expect( page ).to have_content('A Test Fib Sequence', count: 4)
  end

  def create_fib
    visit '/fibs'
    click_link 'New Fib'
    fill_in 'fib[name]', with: 'this is a test fib'
    fill_in 'fib[sequence_length]', with: '10'
    click_button 'Create Fib'
  end
end