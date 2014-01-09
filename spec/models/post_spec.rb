require 'spec_helper'

describe Post do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  it { should belong_to(:category) }
  it { should belong_to(:user) }

end
