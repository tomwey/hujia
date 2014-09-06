# coding: utf-8
# College.create(name: "西华师范大学")
# College.create(name: "川北医学院")
# College.create(name: "四川大学")
# College.create(name: "电子科技大学")

# ServiceArea.create(name: "顺庆区")
# ServiceArea.create(name: "嘉陵区")
# ServiceArea.create(name: "高坪区")

Province.destroy_all
p1 = Province.create!(name: "四川", code: "510000")
p2 = Province.create!(name: "云南", code: "530000")

City.destroy_all
c1 = City.create!(name: "成都", code: "510100", province_id: p1.id)
c2 = City.create!(name: "南充", code: "511300", province_id: p1.id)

c3 = City.create!(name: "昆明", code: "530100", province_id: p2.id)

College.destroy_all

College.create(name: "西华师范大学", city_id: c2.id)
College.create(name: "川北医学院", city_id: c2.id)

College.create(name: "四川大学", city_id: c1.id)
College.create(name: "电子科技大学", city_id: c1.id)

College.create(name: "云南大学", city_id: c3.id)
