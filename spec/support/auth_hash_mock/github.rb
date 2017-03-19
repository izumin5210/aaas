module AuthHashMock
  module GitHub
    extend ActiveSupport::Concern

    included do
      let(:uid) { '1234567' }
      let(:provider) { 'github' }
      let(:nickname) { 'testuser' }

      let(:auth_hash) do
        OmniAuth::AuthHash.new({
          'provider'    => provider,
          'uid'         => uid,
          'info'        => info,
          'credentials' => credentials,
          'extra'       => { 'raw_info' => raw_info },
        })
      end

      let(:credentials) do
        { 'expires' => false,
          'token'   => 'access_token',
        }
      end

      let(:info) do
        { 'email'     => 'testuser@example.com',
          'image'     => 'https://example.com/images/#{nickname}.png',
          'name'      => 'John Doe',
          'nickname'  => 'testuser',
          'urls'      => {
            'Blog'      => 'http://example.com/',
            'GitHub'    => 'https://github.example.com/#{nickname}'
          },
        }
      end

      let(:raw_info) do
        { 'avatar_url'          => 'https://example.com/images/#{nickname}.png',
          'bio'                 => 'testuser: John Doe',
          'blog'                => 'http://example.com/',
          'company'             => 'testcompany',
          'created_at'          => '2016-09-24T12:34:56Z',
          'email'               => 'testuser@example.com',
          'events_url'          => 'https://api.github.example.com/users/#{nickname}/events{/privacy}',
          'followers'           => 999,
          'followers_url'       => 'https://api.github.example.com/users/#{nickname}/followers',
          'following'           => 333,
          'following_url'       => 'https://api.github.example.com/users/#{nickname}/following{/other_user}',
          'gists_url'           => 'https://api.github.example.com/users/#{nickname}/gists{/gist_id}',
          'gravatar_id'         => '',
          'hireable'            => true,
          'html_url'            => 'https://github.example.com/#{nickname}',
          'id'                  => 1234567,
          'location'            => 'Tokyo, Japan',
          'login'               => 'testuser',
          'name'                => 'John Doe',
          'organizations_url'   => 'https://api.github.example.com/users/#{nickname}/orgs',
          'public_gists'        => 666,
          'public_repos'        => 33,
          'received_events_url' => 'https://api.github.example.com/users/#{nickname}/received_events',
          'repos_url'           => 'https://api.github.example.com/users/#{nickname}/repos',
          'site_admin'          => false,
          'starred_url'         => 'https://api.github.example.com/users/#{nickname}/starred{/owner}{/repo}',
          'subscriptions_url'   => 'https://api.github.example.com/users/#{nickname}/subscriptions',
          'type'                => 'User',
          'updated_at'          => '2016-09-26T01:23:45Z',
          'url'                 => 'https://api.github.example.com/users/#{nickname}',
        }
      end
    end
  end
end
