require 'spec_helper'

describe Contact do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:subject) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }

  it { should have_valid(:email).when('user@test.com', 'someone123@example.com') }
  it { should_not have_valid(:email).when(nil, '', 'user.com', 'foo@com', 'bar@barcom', 'foobar') }


  it { should have_valid(:first_name).when('Melissa', 'Alex') }
  it { should_not have_valid(:first_name).when(nil, '') }

  it { should have_valid(:last_name).when('Smith', 'Doe') }
  it { should_not have_valid(:last_name).when(nil, '') }


end
