Then /^I should see (\d+) comment[s]?$/ do |count|
  with_scope('"div#rating-hist"') do
    page.should have_css("div.rating_disp", :count => count.to_i)
  end
end

Then /^I should see a comment rating of (\d+)$/ do |rating|
  with_scope('"div#rating-hist"') do
    page.should have_css('.rating', :style => "width:#{rating}%")
  end
end

Then /^I should see a service rating of (\d+)$/ do |rating|
  with_scope('"div#current-rating"') do
    page.should have_css('.rating', :style => "width:#{rating}%")
  end
end

Then /^I should not see a comment rating of (\d+)$/ do |rating|
  with_scope('"div#rating-hist"') do
    page.should_not have_css('.rating', :style => "width:#{rating}%")
  end
end

Then /^I should not see a service rating of (\d+)$/ do |rating|
  with_scope('"div#current-rating"') do
    page.should_not have_css('.rating', :style => "width:#{rating}%")
  end
end

Given /^ReallyCare comment approval (is|is not) required$/ do |flag|
  Bc::Application::require_rating_checks = flag == 'is not' ? false : true
end