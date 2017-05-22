function love.conf(t)
	t.releases = {
		title = "l2 engine",
		package = "l2",
		loveVersion = "0.10.2",
		version = "0.1",
		author = "Egor Dorichev",
		email = "egordorichev@gmail.com",
		description = "l2 engine template",
		homepage = nil,
		identifier = "l2",
		excludeFileList = {},
		releaseDirectory = nil
	}

	t.identity = "l2"
	t.version = "0.10.2"
 
	t.window.title = "l2 engine"
	t.window.icon = "data/images/icon.png"
	t.window.width = 480
	t.window.height = 480
	t.window.resizable = false
end
