module ApplicationHelper
  # Returns a string like "an in-home dinner"
  def meal_name_with_indefinite_article(appointment)
    meal_name = [@appointment.css_class, "dinner"].join(' ')
    meal_name.with_indefinite_article
  end
end
