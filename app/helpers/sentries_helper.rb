module SentriesHelper
  def sentry_state(sentry)
    if sentry.state?
      image_tag("/images/icons/emoticon_grin.png")
    else
      image_tag("/images/icons/emoticon_unhappy.png")
    end
  end
end