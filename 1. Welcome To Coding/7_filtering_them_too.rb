require '/tmp/shadow_code'

user_name = "mi-ward"

subreddits = ["aww", "awww", "hardcoreaww", "puppies"]

filter_by(["!","dog"])

posts = get_posts(subreddits)

posts = sort_posts(posts, "title")

render_posts(user_name, posts)