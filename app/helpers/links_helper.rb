module LinksHelper

  def vote_down_button(link)
    link_to content_tag(:i, class: "icon-caret-down icon-4x myvotearrow"), vote_down_link_path(link), :method => :post
  end

  def vote_up_button(link)
    link_to content_tag(:i, class: "icon-caret-up icon-4x myvotearrow"), vote_up_link_path(link), :method => :post
  end

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
