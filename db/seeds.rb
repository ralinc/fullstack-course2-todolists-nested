Profile.delete_all
User.delete_all
TodoItem.delete_all
TodoList.delete_all

profiles = [{
  first_name: "Carly",
  last_name: "Fiorina",
  birth_year: 1954,
  gender: "female"
}, {
  first_name: "Donald",
  last_name: "Trump",
  birth_year: 1946,
  gender: "male"
}, {
  first_name: "Ben",
  last_name: "Carson",
  birth_year: 1951,
  gender: "male"
},{
  first_name: "Hillary",
  last_name: "Clinton",
  birth_year: 1947,
  gender: "female"
}]

users = profiles.map {|profile|  { username: profile[:last_name], password_digest: "12345"} }

init_date = Date.today + 1.year

4.times do |i|
  user = users[i]
  profile = profiles[i]

  list = TodoList.create! ({
    list_name: "#{user[:username]}'s tasks",
    list_due_date: init_date
  })

  5.times do |j|
    item = TodoItem.create! ({
      due_date: init_date,
      title: "item ##{(i * 5) + j + 1}",
      description: "from list [#{list[:list_name]}]",
      completed: false
    })

    list.todo_items << item
  end

  user = User.create! users[i]
  user.profile = Profile.create! profile
  user.todo_lists << list
  user.save
end
