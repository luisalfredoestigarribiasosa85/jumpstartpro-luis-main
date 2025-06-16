require "test_helper"

class Users::SessionsControllerTest < ActionDispatch::IntegrationTest
  class LoginTest < Users::SessionsControllerTest
    test "successful user session" do
      user = users(:one)
      post new_user_session_url, params: {user: {email: user.email, password: "password"}}
      assert_response :redirect
    end

    test "failed user session" do
      user = users(:one)
      post new_user_session_url, params: {user: {email: user.email, password: "invalid-password"}}
      # Devise renders 200 OK on failure
      assert_response :success
    end
  end

  class MarketplaceLoginTest < Users::SessionsControllerTest
    test "cannot login with marketplace account on primary domain" do
      Jumpstart.config.stub :marketplace?, true do
        user = users(:marketplace_customer)
        post new_user_session_url, params: {user: {email: user.email, password: "password"}}
        # Devise renders 200 OK on failure
        assert_response :success
      end
    end

    test "can login on marketplace subdomain" do
      Jumpstart.config.stub :marketplace?, true do
        Jumpstart::Multitenancy.stub :subdomain?, true do
          host! "#{accounts(:marketplace).subdomain}.example.com"
          user = users(:marketplace_customer)
          post new_user_session_url, params: {user: {email: user.email, password: "password"}}
          assert_response :redirect
        end
      end
    end

    test "can login on marketplace domain" do
      Jumpstart.config.stub :marketplace?, true do
        Jumpstart::Multitenancy.stub :domain?, true do
          host! accounts(:marketplace).domain
          user = users(:marketplace_customer)
          post new_user_session_url, params: {user: {email: user.email, password: "password"}}
          assert_response :redirect
        end
      end
    end
  end
end
