require '/tmp/shadow_code'

user_name = "mi-ward"

subreddit = "hardcoreaww"

number_of_posts = 10

posts = get_posts(subreddit, number_of_posts)

render_posts(user_name, posts)