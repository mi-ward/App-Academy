require '/tmp/shadow_code'

user_name = "mi-ward"

subreddits = ["aww", "awww", "hardcoreaww", "puppies"]

number_of_posts = 20

posts = get_posts(subreddits, number_of_posts)

posts = sort_posts(posts, "date")

render_posts(user_name, posts)