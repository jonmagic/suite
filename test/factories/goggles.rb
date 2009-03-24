Factory.define :goggle do |f|
  f.name "Alive Test"
  f.module "i_am_alive"
  f.script "last(5.minutes).any_post.has('alive')"
  f.note "This is just to test if a host is alive"
end