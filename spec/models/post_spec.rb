require 'spec_helper'

describe Post do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  it { should belong_to(:category) }
  it { should belong_to(:user) }


  describe '#inspired_post_count' do
    it 'returns zero if no inspired posts' do
      post = FactoryGirl.create(:post)
      expect(post.inspired_post_count).to eq(0)
    end

    it 'counts the number of direct children' do
      parent = FactoryGirl.create(:post)
      children = FactoryGirl.create_list(:post, 3, parent: parent)

      expect(parent.inspired_post_count).to eq(3)
    end

    it 'counts all descendants' do
      parent = FactoryGirl.create(:post)
      child = FactoryGirl.create(:post, parent: parent)
      child2 = FactoryGirl.create(:post, parent: parent)
      grandchild = FactoryGirl.create(:post, parent: child)

      expect(parent.inspired_post_count).to eq(3)
    end
  end
end
