module ApplicationHelper
  # Returns a string like "an in-home dinner"
  def meal_name_with_indefinite_article(meal)
    meal_name = [meal.css_class, Figaro.env.meal_name].join(' ')
    meal_name.with_indefinite_article
  end
end
