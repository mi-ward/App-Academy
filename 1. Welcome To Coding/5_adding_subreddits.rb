require '/tmp/shadow_code'

user_name = "{{ user.first_name }}"

subreddits = ["aww", "awww", "hardcoreaww", "puppies"]

number_of_posts = 20

posts = get_posts(subreddits, number_of_posts)

render_posts(user_name, posts)