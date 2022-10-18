require "test_helper"

class BookingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = FactoryBot.create(:user, :student_secondary)
    @edition = FactoryBot.create(:edition, bookable_in_presence, seats: 10)
    post '/auth/developer/callback', params: { name: @user.email }
  end

  test 'new booking page has 10 posti disponibili in presenza' do
    get new_edition_booking_url(@edition)
    assert_response :success
    assert_select 'div', text: /10 posti disponibili in presenza/
  end

  # test "should get index" do
  #   get high_scores_url
  #   assert_response :success
  # end

  # test "should get new" do
  #   get new_high_score_url
  #   assert_response :success
  # end

  # test "should create high_score" do
  #   assert_difference("HighScore.count") do
  #     post high_scores_url, params: { high_score: { game: @high_score.game, score: @high_score.score } }
  #   end

  #   assert_redirected_to high_score_url(HighScore.last)
  # end

  # test "should show high_score" do
  #   get high_score_url(@high_score)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_high_score_url(@high_score)
  #   assert_response :success
  # end

  # test "should update high_score" do
  #   patch high_score_url(@high_score), params: { high_score: { game: @high_score.game, score: @high_score.score } }
  #   assert_redirected_to high_score_url(@high_score)
  # end

  # test "should destroy high_score" do
  #   assert_difference("HighScore.count", -1) do
  #     delete high_score_url(@high_score)
  #   end

  #   assert_redirected_to high_scores_url
  # end
end
