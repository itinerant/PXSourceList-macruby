#
#  AppDelegate.rb
#  PXSourceList-macruby
#
#  Created by Jon Doud on 10/4/11.
#  Copyright 2011 Itinerant Software Solutions. All rights reserved.
#

framework 'PXSourceList'
require 'SourceListItem'


class AppDelegate
  attr_accessor :window
  attr_accessor :sourceList
  attr_accessor :selectedItemLabel
  
  attr_accessor :sourceListItems
  
  def awakeFromNib
    @sourceListItems = []
    @selectedItemLabel.stringValue = "(none)"
=begin
    # Set up the "Library" parent item and children
    libraryItem = SourceListItem.new("LIBRARY", "library")
    musicItem = SourceListItem.new("Music", "music")
    musicItem.icon = "music.png"
    moviesItem = SourceListItem.new("Movies", "movies")
    moviesItem.icon = "movies.png"
    podcastsItem = SourceListItem.new("Podcasts", "podcasts")
    podcastsItem.icon = "podcasts.png"
    podcastsItem.badgeValue = 10
    audiobooksItem = SourceListItem.new("Audiobooks", "audiobooks")
    audiobooksItem.icon = "audiobooks.png"
    libraryItem.children = [musicItem, moviesItem, podcastsItem, audiobooksItem]
    
    # Set up the "Playlists" parent item and children
    playlistsItem = SourceListItem.new("PLAYLISTS", "playlists")
    playlist1Item = SourceListItem.new("Playlist1", "playlist1")
    
    # Create a second-level group to demonstrate
    playlist2Item = SourceListItem.new("Playlist2", "playlist2")
    playlist3Item = SourceListItem.new("Playlist3", "playlist3")
    playlist1Item.icon = "playlist.png"
    playlist2Item.icon = "playlist.png"
    playlist3Item.icon = "playlist.png"
    
    playlistGroup = SourceListItem.new("Playlist Group", "playlistgroup")
    playlistGroupItem = SourceListItem.new("Child Playlist", "childplaylist")
    playlistGroup.icon = "playlistFolder.png"
    playlistGroupItem.icon = "playlist.png"
    playlistGroup.children = [playlistGroupItem]
    
    playlistsItem.children = [playlist1Item, playlistGroup,playlist2Item, playlist3Item]
    
    @sourceListItems.addObject(libraryItem)
    @sourceListItems.addObject(playlistsItem)
    
    @sourceListItems.each do |i|
      puts i
    end
    puts @sourceListItems[0].children[1].title
    puts @sourceListItems[0].children[1].identifier
    puts @sourceListItems[0].children[1].icon
    puts @sourceListItems[0].children[1].badgeValue
    puts @sourceListItems[0].children[1].children.size
    
    @sourceList.reloadData
=end
  end
  
 
  def sourceList(sourceList, numberOfChildrenOfItem:item)
    # Works the same way as the NSOutlineView data source: `nil` means a parent item
    if(item==nil)
      return @sourceListItems.size
    else
      return item.children.size
    end
  end
    
    
  def sourceList(aSourceList, child:index, ofItem:item)
    # Works the same way as the NSOutlineView data source: `nil` means a parent item
    puts "child: #{index}"
    if(item==nil)
      return @sourceListItems.objectAtIndex(index)
    else
      return item.children.objectAtIndex(index)
    end
  end

  
  def sourceList(aSourceList, objectValueForItem:item)
    return item.title
  end
  
  
  def sourceList(aSourceList, setObjectValue:object, forItem:item)
    item.title = object
  end
  
  
  def sourceList(aSourceList, isItemExpandable:item)
    return item.hasChildren
  end
  
  
  def sourceList(aSourceList, itemHasBadge:item)
    return item.hasBadge
  end
  
  
  def sourceList(aSourceList, badgeValueForItem:item)
    return item.badgeValue
  end
  
  
  def sourceList(aSourceList, itemHasIcon:item)
    return item.hasIcon
  end
  
  
  def sourceList(aSourceList, iconForItem:item)
    return item.icon
  end
  
  
  def sourceList(aSourceList, menuForEvent:theEvent, item:item)
    if (theEvent.type == NSRightMouseDown || (theEvent.type == NSLeftMouseDown && (theEvent.modifierFlags & NSControlKeyMask) == NSControlKeyMask))
      NSMenu m = NSMenu.alloc.init
      if (item != nil)
        m.addItemWithTitle(item.title, action:nil, keyEquivalent:"")
      else
        m.addItemWithTitle("clicked outside", action:nil, keyEquivalent:"")
      end
      return m
    else
      return nil
    end
  end
          
        
  def sourceList(aSourceList, isGroupAlwaysExpanded:group)
    if(group.identifier == "library")
      return true
    end
    return false
  end
  
  def sourceListSelectionDidChange(a_notification)
    NSIndexSet selectedIndexes = @sourceList.selectedRowIndexes
      
    # Set the label text to represent the new selection
    if(selectedIndexes.size>1)
      selectedItemLabel.stringValue = "(multiple)"
    elsif(selectedIndexes.size==1)
      identifier = @sourceList.itemAtRow(selectedIndexes.firstIndex.identifier)
      selectedItemLabel.stringValue = identifier
    else
      selectedItemLabel.stringValue = "(none)"
    end
  end

end

