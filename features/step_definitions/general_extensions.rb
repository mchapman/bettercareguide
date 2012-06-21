When /^(?:|I )select \\([^\\]*)\\ from "([^"]*)"(?: within "([^"]*)")?$/ do |value, field, selector|
  eval_value = eval value
  with_scope(selector) do
    select(eval_value, :from => field)
  end
end

Then /^(?:|I )should see css "([^"]*)"(?: within "([^"]*)")?$/ do |text, selector|
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_css(text)
    else
      assert page.has_css?(text)
    end
  end
end

Then /^(?:|I )should see \\([^\\]*)\\(?: within "([^"]*)")?$/ do |text, selector|
  eval_value = eval text
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_content(eval_value)
    else
      assert page.has_content?(eval_value)
    end
  end
end
