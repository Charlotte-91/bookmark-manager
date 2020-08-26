feature 'viewing bookmarks show me all the bookmarks'  do
  scenario 'viewing bookmarks show me all the bookmarks'  do
    Bookmark.create(url: "https://www.google.com", title: 'Google')
    Bookmark.create(url: "https://www.instagram.com", title: 'Instagram')
    Bookmark.create(url: "https://www.facebook.com", title: 'Facebook')
  
    visit '/bookmarks'

    expect(page).to have_link('Google', href: 'https://www.google.com')
    expect(page).to have_link('Instagram', href: 'https://www.instagram.com')
    expect(page).to have_link('Facebook', href: 'https://www.facebook.com')
  end
end

