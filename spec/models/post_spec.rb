require 'spec_helper'

describe Post do
  it "title should be automatically titleized before save" do
    test_title = Post.new(title: "un titleized title", content: "idgaf")
    test_title.save
    test_title.title.should == "Un Titleized Title"
  end

  it "post should be unpublished by default" do
    test_post = Post.create(title: "un titleized title", content: "idgaf")
    test_post.is_published.should == false
  end

  # a slug is an automaticaly generated url-friendly
  # version of the title
  it "slug should be automatically generated" do
    post = Post.new
    post.title   = "New post!"
    post.content = "A great story"
    post.slug.should be_nil
    post.save

    post.slug.should eq "new-post"
  end
end
