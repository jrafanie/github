# encoding: utf-8

require 'spec_helper'

describe Github::Client::Users::Emails, '#list' do
  let(:email) { "octocat@github.com" }
  let(:request_path) { "/user/emails" }

  before {
    subject.oauth_token = OAUTH_TOKEN
    stub_delete(request_path).with(:query => { :access_token => "#{OAUTH_TOKEN}"}).
      to_return(:body => body, :status => status,
        :headers => {:content_type => "application/json; charset=utf-8"})
  }

  after { reset_authentication_for(subject) }

  let(:params) { { :per_page => 21, :page => 1 }}
  let(:body) { fixture('users/emails.json') }
  let(:status) { 204 }

  it 'extracts request parameters and email data' do
    subject.should_receive(:delete_request).
      with(request_path, { "per_page" => 21, "page" => 1, 'data' => [email] })
    subject.delete email, params
  end

  it 'submits request successfully' do
    subject.delete email
    a_delete(request_path).with(:query => { :access_token => "#{OAUTH_TOKEN}" } ).
      should have_been_made
  end
end # delete
