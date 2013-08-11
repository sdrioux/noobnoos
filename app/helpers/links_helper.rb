module LinksHelper

  def show_favorite_star(user, link)
    if user == nil
      return nil
    else
      if Favorite.exists?(user_id: user.id, link_id: link.id)
        link_to_function raw('<i class="icon-star icon-large"></i>'), "$.ajax({url:'/links/#{link.id}/favorite', type: 'PUT'});"
      else 
        link_to_function raw('<i class="icon-star icon-large icon-muted"></i>'), "$.ajax({url:'/links/#{link.id}/favorite', type: 'PUT'});"
      end
    end
  end
end
