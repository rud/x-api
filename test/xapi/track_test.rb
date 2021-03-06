require './test/test_helper'
require 'json'
require 'xapi/track'

class TrackTest < Minitest::Test
  def test_basic_configuration
    track = Xapi::Track.new("./test/fixtures/problems/fruit")
    assert track.active?
    assert_equal "fruit", track.slug
    assert_equal "Fruit", track.language
    assert_equal ["apple", "banana", "cherry"], track.problem_slugs
    assert_equal ["apple", "banana", "cherry"], track.problems.map(&:slug).sort
    assert_equal ["fruit/apple", "fruit/banana", "fruit/cherry"], track.problem_ids
  end

  def test_inactive_language
    track = Xapi::Track.new("./test/fixtures/problems/jewels")
    refute track.active?
    assert_equal "jewels", track.slug
    assert_equal "Fancy Stones", track.language
    assert_equal [], track.problem_ids
  end
end
