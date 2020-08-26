feature 'Creating a bookmark' do
    scenario 'allows user to create a new bookmark' do
        visit '/bookmarks/new'
        fill_in :url, with: 'http://wwww.testbookmark.com'
        fill_in('title', with: 'Test Bookmark')
        click_button('Submit')

        expect(page).to have_link('Test Bookmark', href: 'http://wwww.testbookmark.com')
    end
end 