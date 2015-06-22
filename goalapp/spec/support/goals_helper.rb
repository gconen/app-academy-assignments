module GoalsHelper
  def create_goal_for(options)
    default_hash = { privacy: false, name: "Test Goal" }
    options = default_hash.merge(options)
    sign_in_as(options[:user])
    visit "/goals/new"

    fill_in "Name", with: options[:name]
    fill_in "Body", with: "Pass a spec."
    check('Private') if options[:privacy]

    click_button "Create Goal"
  end
end
