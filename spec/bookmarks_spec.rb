require './lib/bookmarks.rb'

describe '.all' do
  it 'displays a list of urls' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    bookmark = Bookmark.create(url: 'http://www.facebook.com', title: 'Facebook')
    Bookmark.create(url: 'http://www.google.com', title: 'Google')
    Bookmark.create(url: 'http://www.instagram.com', title: 'Instagram')

    bookmarks = Bookmark.all

    expect(bookmarks.length).to eq 3
    expect(bookmarks.first).to be_a Bookmark
    expect(bookmarks.first.id).to eq bookmark.id
    expect(bookmarks.first.title).to eq 'Facebook'
    expect(bookmarks.first.url).to eq 'http://www.facebook.com'
  end
end

describe '.create' do
  it 'creates a new bookmark' do
    bookmark = Bookmark.create(url: 'http://wwww.testbookmark.com', title: 'Test Bookmark')
    persisted_data = PG.connect(dbname: 'bookmark_manager_test').query("SELECT * FROM bookmarks WHERE id = #{bookmark.id};")

    expect(bookmark).to be_a Bookmark
    expect(bookmark.id).to eq persisted_data.first['id']
    expect(bookmark.title).to eq 'Test Bookmark'
    expect(bookmark.url).to eq 'http://wwww.testbookmark.com'
  end 
end 

describe '.delete' do
  it 'deletes the selected bookmark' do
    bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')

    Bookmark.delete(id: bookmark.id)

    expect(Bookmark.all.length).to eq 0
  end
end

describe '.update' do
  it 'updates the bookmark with the given data' do
    bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')
    updated_bookmark = Bookmark.update(id: bookmark.id, url: 'http://www.snakersacademy.com', title: 'Snakers Academy')

    expect(updated_bookmark).to be_a Bookmark
    expect(updated_bookmark.id).to eq bookmark.id
    expect(updated_bookmark.title).to eq 'Snakers Academy'
    expect(updated_bookmark.url).to eq 'http://www.snakersacademy.com'
  end
end

describe '.find' do
  it 'returns the requested bookmark object' do
    bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')

    result = Bookmark.find(id: bookmark.id)

    expect(result).to be_a Bookmark
    expect(result.id).to eq bookmark.id
    expect(result.title).to eq 'Makers Academy'
    expect(result.url).to eq 'http://www.makersacademy.com'
  end
end

