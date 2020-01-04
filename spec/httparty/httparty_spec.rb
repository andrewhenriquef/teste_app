require 'rails_helper'

describe 'HTTParty' do
  # it 'content-type', vcr: { cassette_name: 'jsonplaceholder/posts', match_requests_on: [:body] } do
  it 'content-type', vcr: { cassette_name: 'jsonplaceholder/posts', record: :new_episodes } do
    # webmock example
    # stub_request(:get, "https://jsonplaceholder.typicode.com/posts/2").
    #   to_return(
    #     status: 200,
    #     body: '',
    #     headers: {
    #       'content-type': 'application/json; chartset: utf-8'
    #     }
    #   )

    # VCR record mods
    # once, default
    # new_episodes, every time that i change the url will record again
    # none, never will generate a request
    # all, will record always

    response = HTTParty.get('https://jsonplaceholder.typicode.com/posts/3')
    content_type = response.headers['content-type']
    expect(content_type).to match(/application\/json/)
  end
end
