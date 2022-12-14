# frozen_string_literal: true

require 'rails_helper'

describe Accounts::BooksController do
  before do
    account = FactoryBot.create(:account)
    # Needs to exist (and have called Resque.enqueue) before we trigger the post-receive hook
    # @book = FactoryBot.create(:book)
    @book = create_book!(account)
  end

  it 'post-receive hooks' do
    expect(Book).to receive(:find_by).and_return(@book)
    expect(@book).to receive(:enqueue)
    process :receive, method: :post, params: { id: @book.permalink }
  end
end
