require('vis')

vis.events.start = function()
    vis:command('set autoindent yes')
    vis:command('set expandtab yes')
    vis:command('set tabwidth 4')
    vis:command('set show tabs 1')
end

vis.events.win_open = function(win)
	vis.filetype_detect(win)
end
