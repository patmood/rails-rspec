require 'spec_helper'

describe 'Admin' do
  context "on admin homepage" do

    before do
      @post = Post.create(title: "Some Title", content: "idgaf")
      if page.driver.respond_to?(:basic_auth)
        page.driver.basic_auth("geek", "jock")
      elsif page.driver.respond_to?(:basic_authorize)
        page.driver.basic_authorize("geek", "jock")
      elsif page.driver.respond_to?(:browser) && page.driver.browser.respond_to?(:basic_authorize)
        page.driver.browser.basic_authorize("geek", "jock")
      else
        raise "I don't know how to log in!"
      end
    end



    it "can see a list of recent posts" do
      visit '/admin/posts'
      page.should have_content(@post.title)
    end

    it "can edit a post by clicking the edit link next to a post" do
      visit admin_posts_path
      click_link('Edit')
      fill_in 'post[title]', :with => 'Aint That'
      fill_in 'post[content]', :with => 'Some shit...'
      click_button('Save')
      current_url.should == admin_post_url(@post)
    end

    it "can delete a post by clicking the delete link next to a post" do
      visit admin_post_path
      click_link('Delete')
      # Require jQuery
      # Require jQuery UI
    end


    it "can create a new post and view it" do
       visit new_admin_post_url

       expect {
         fill_in 'post_title',   with: "Hello world!"
         fill_in 'post_content', with: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat."
         page.check('post_is_published')
         click_button "Save"
       }.to change(Post, :count).by(1)

       page.should have_content "Published: true"
       page.should have_content "Post was successfully saved."
     end
  end

  context "editing post" do
    it "can mark an existing post as unpublished" do
      pending # remove this line when you're working on implementing this test

      page.should have_content "Published: false"
    end
  end

  context "on post show page" do
    it "can visit a post show page by clicking the title"
    it "can see an edit link that takes you to the edit post path"
    it "can go to the admin homepage by clicking the Admin welcome page link"
  end
end
