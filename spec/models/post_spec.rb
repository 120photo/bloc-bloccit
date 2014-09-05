require 'rails_helper'

describe Post do
  describe "vote methods" do

    before do
      @post = associate_post
      allow(@post).to receive(:create_vote)
      @post.save
      3.times { @post.votes.create(value: 1) }
      2.times { @post.votes.create(value: -1) }
    end

    describe '#up_votes' do
      it "counts the number of votes with value = 1" do
        expect( @post.up_votes ).to eq(3)
      end
    end

    describe '#down_votes' do
      it "counts the number of votes with calue = -1" do
        expect( @post.down_votes ).to eq(2)
      end
    end

    describe '#points' do
      it "returns the sum of all down and up votes" do
        expect( @post.points ).to eq(1) # 3 - 2
      end
    end
  end

  def associate_post(options={})
    post_options = {
      title: 'Post title',
      body: 'Post bodies must be pretty long.',
      topic: Topic.create(name: 'Topic name'),
      user: authenticated_user
    }.merge(options)
    Post.create(post_options)
  end

  def authenticated_user(options={})
    user_options = {email: "email#{rand}@fake.com", password: 'password'}.merge(options)
    user = User.new(user_options)
    user.skip_confirmation!
    user.save
    user
  end

end
