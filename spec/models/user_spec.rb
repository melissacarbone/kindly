require 'spec_helper'

describe User do
  it { should have_valid(:first_name).when('Melissa', 'Alex') }
  it { should_not have_valid(:first_name).when(nil, '') }

  it { should have_valid(:last_name).when('Smith', 'Doe') }
  it { should_not have_valid(:last_name).when(nil, '') }

  it { should have_valid(:email).when('user@test.com', 'someone123@example.com') }
  it { should_not have_valid(:email).when(nil, '', 'user.com', 'foo@com', 'bar@barcom', 'foobar') }

  it 'has a matching password confirmation for password' do
    user = User.new

    user.password = 'password'
    user.password_confirmation = 'different password'

    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank

  end
end
