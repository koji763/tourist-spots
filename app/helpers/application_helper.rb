module ApplicationHelper
  include Pagy::Frontend
  
  # 星評価の為のメソッド
  def star_rating(rating)
    full_stars = rating.floor
    half_star = (rating - full_stars) >= 0.5
    empty_stars = 5 - full_stars - (half_star ? 1 : 0)

    full_star_html = (1..full_stars).map { '<i class="fa fa-star full-star"></i>' }.join
    half_star_html = half_star ? '<i class="fa fa-star-half-alt half-star"></i>' : ''
    empty_star_html = (1..empty_stars).map { '<i class="fa-regular fa-star empty-star"></i>' }.join

    (full_star_html + half_star_html + empty_star_html).html_safe
  end
end
