module LinksHelper

  def show_favorite_star(user, link)
    #default favorite_star classes
    favorite_classes = "icon-star icon-large"
    #if the link is NOT a favorite for the user, add class to make the star gray.
    favorite_classes += " icon-muted" if !Favorite.exists?(user_id: user.id, link_id: link.id)
    #display the star with the correct classes.
    link_to_function raw("<i class='#{favorite_classes}'></i>"), "$.ajax({url:'/links/#{link.id}/favorite', type: 'PUT'});"
  end
end