# coding: utf-8
module CollegesHelper
  def render_college_city_select_tag(college)
    return '' if college.blank?
    grouped_collection_select :college, :city_id, Province.all,
                    :sorted_cities, :name, :id, :name, {:value => college.city_id,
                    :prompt => "-- 选择校区 --"}, :style => "width:145px;"
  end
end