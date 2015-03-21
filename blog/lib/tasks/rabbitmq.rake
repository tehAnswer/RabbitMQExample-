namespace :rabbitmq do
  desc "Setup routing"
  task :setup do
    require "bunny"

    conn = Bunny.new
    conn.start

    ch = conn.create_channel
    x = ch.fanout("blog.posts")

    queue = ch.queue("dashboard.posts", durable: true)
    queue.bind("blog.posts")

    conn.close
  end
end