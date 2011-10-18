#
#  SourceListItem.rb
#  PXListViewDemo
#
#  Created by Jon Doud on 10/4/11.
#  Copyright 2011 Itinerant Software Solutions. All rights reserved.
#


class SourceListItem
  attr_accessor :title, :identifier, :icon, :badgeValue
  attr_accessor :children
  
  
  def initialize(aTitle, anIdentifier)
    @title = aTitle
    @identifier = anIdentifier
    @icon = nil
    @badgeValue = -1 # We don't want a badge value by default
    @children = []    
  end
  
  
  def hasBadge
    return badgeValue != -1
  end
  
  
  def hasChildren
    return children.size > 0
  end
  
  
  def hasIcon
    return icon != nil
  end
  
  
  def to_s
    out =  "#{@title} (#{@identifier}) <#{@icon}, #{@badgeValue}, - Children: "
  
    children.each do |c|
      out += "#{c.title}, "
    end
    out = out.chop.chop
    out += ">"
    puts out
  end
    
  
end