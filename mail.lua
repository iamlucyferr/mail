local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

----------------------------------------------------
-- ITEM DATABASE
----------------------------------------------------
local ItemDatabase = {
	-- Pets
	{name = "Unicorn", category = "Pets", icon = "🦄"},
	{name = "BlackDragon", category = "Pets", icon = "🐉"},
	{name = "GoldenDragonfly", category = "Pets", icon = "🐝"},
	{name = "Raccoon", category = "Pets", icon = "🦝"},
	{name = "Owl", category = "Pets", icon = "🦉"},
	{name = "Bee", category = "Pets", icon = "🐝"},
	{name = "Frog", category = "Pets", icon = "🐸"},
	{name = "Bunny", category = "Pets", icon = "🐰"},
	{name = "Monkey", category = "Pets", icon = "🐒"},
	{name = "Deer", category = "Pets", icon = "🦌"},
	{name = "Robin", category = "Pets", icon = "🐦"},
	{name = "IceSerpent", category = "Pets", icon = "🐍"},

	-- Seeds
	{name = "Rainbow", category = "Seeds", icon = "🌈"},
	{name = "Gold", category = "Seeds", icon = "🪙"},
	{name = "Dragon's Breath", category = "Seeds", icon = "🔥"},
	{name = "Ghost Pepper", category = "Seeds", icon = "🌶️"},
	{name = "Bamboo", category = "Seeds", icon = "🎋"},
	{name = "Strawberry", category = "Seeds", icon = "🍓"},
	{name = "Carrot", category = "Seeds", icon = "🥕"},
	{name = "Pineapple", category = "Seeds", icon = "🍍"},
	{name = "Mango", category = "Seeds", icon = "🥭"},
	{name = "Dragon Fruit", category = "Seeds", icon = "🐉"},
	{name = "Coconut", category = "Seeds", icon = "🥥"},
	{name = "Corn", category = "Seeds", icon = "🌽"},
	{name = "Cactus", category = "Seeds", icon = "🌵"},
	{name = "Blueberry", category = "Seeds", icon = "🫐"},
	{name = "Tomato", category = "Seeds", icon = "🍅"},
	{name = "Apple", category = "Seeds", icon = "🍎"},
	{name = "Cherry", category = "Seeds", icon = "🍒"},
	{name = "Sunflower", category = "Seeds", icon = "🌻"},

	-- Sprinklers
	{name = "Super Sprinkler", category = "Sprinklers", icon = "💦"},
	{name = "Legendary Sprinkler", category = "Sprinklers", icon = "💦"},
	{name = "Rare Sprinkler", category = "Sprinklers", icon = "💦"},
	{name = "Uncommon Sprinkler", category = "Sprinklers", icon = "💦"},
	{name = "Common Sprinkler", category = "Sprinklers", icon = "💦"},

	-- Watering Cans
	{name = "Super Watering Can", category = "WateringCans", icon = "🚿"},
	{name = "Common Watering Can", category = "WateringCans", icon = "🚿"}
}

----------------------------------------------------
-- MAIN GUI CONTAINER
----------------------------------------------------
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DropdownMailGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

----------------------------------------------------
-- FLOATING TOGGLE BUTTON (OPEN / CLOSE)
----------------------------------------------------
local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleOpenBtn"
toggleBtn.Size = UDim2.new(0, 110, 0, 36)
toggleBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
toggleBtn.Text = "Mail UI ✉️"
toggleBtn.TextColor3 = Color3.fromRGB(255, 190, 0)
toggleBtn.TextSize = 12
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.Parent = screenGui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 8)
toggleCorner.Parent = toggleBtn

local toggleStroke = Instance.new("UIStroke")
toggleStroke.Color = Color3.fromRGB(255, 190, 0)
toggleStroke.Thickness = 1.5
toggleStroke.Parent = toggleBtn

----------------------------------------------------
-- MAIN WINDOW FRAME
----------------------------------------------------
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0.9, 0, 0.85, 0)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = true
mainFrame.Parent = screenGui

local sizeConstraint = Instance.new("UISizeConstraint")
sizeConstraint.MaxSize = Vector2.new(380, 600)
sizeConstraint.MinSize = Vector2.new(280, 440)
sizeConstraint.Parent = mainFrame

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = mainFrame

----------------------------------------------------
-- TOP BAR & DRAG LOGIC
----------------------------------------------------
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 36)
topBar.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0, 8)
topBarCorner.Parent = topBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -70, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Mail Control ✉️"
title.TextColor3 = Color3.fromRGB(255, 190, 0)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 26, 0, 24)
minimizeBtn.Position = UDim2.new(1, -60, 0, 6)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimizeBtn.Text = "➖"
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.TextSize = 10
minimizeBtn.Parent = topBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 26, 0, 24)
closeBtn.Position = UDim2.new(1, -30, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
closeBtn.Text = "❌"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 10
closeBtn.Parent = topBar

-- Draggable Main Frame
local dragging, dragInput, mousePos, framePos
topBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		mousePos = input.Position
		framePos = mainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)

topBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - mousePos
		mainFrame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
	end
end)

----------------------------------------------------
-- NAVIGATION TABS
----------------------------------------------------
local navBar = Instance.new("Frame")
navBar.Name = "NavBar"
navBar.Size = UDim2.new(0.9, 0, 0, 32)
navBar.Position = UDim2.new(0.05, 0, 0, 42)
navBar.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
navBar.BorderSizePixel = 0
navBar.Parent = mainFrame

local navCorner = Instance.new("UICorner")
navCorner.CornerRadius = UDim.new(0, 6)
navCorner.Parent = navBar

local sendTabBtn = Instance.new("TextButton")
sendTabBtn.Size = UDim2.new(0.5, -2, 1, 0)
sendTabBtn.Position = UDim2.new(0, 0, 0, 0)
sendTabBtn.BackgroundColor3 = Color3.fromRGB(255, 190, 0)
sendTabBtn.Text = "✉️ Send Mail"
sendTabBtn.TextColor3 = Color3.fromRGB(20, 20, 20)
sendTabBtn.TextSize = 11
sendTabBtn.Font = Enum.Font.GothamBold
sendTabBtn.Parent = navBar

local sendTabCorner = Instance.new("UICorner")
sendTabCorner.CornerRadius = UDim.new(0, 6)
sendTabCorner.Parent = sendTabBtn

local historyTabBtn = Instance.new("TextButton")
historyTabBtn.Size = UDim2.new(0.5, -2, 1, 0)
historyTabBtn.Position = UDim2.new(0.5, 2, 0, 0)
historyTabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
historyTabBtn.Text = "📜 History Log"
historyTabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
historyTabBtn.TextSize = 11
historyTabBtn.Font = Enum.Font.GothamBold
historyTabBtn.Parent = navBar

local historyTabCorner = Instance.new("UICorner")
historyTabCorner.CornerRadius = UDim.new(0, 6)
historyTabCorner.Parent = historyTabBtn

----------------------------------------------------
-- TAB 1: SEND MAIL PAGE
----------------------------------------------------
local sendPage = Instance.new("Frame")
sendPage.Name = "SendPage"
sendPage.Size = UDim2.new(1, 0, 1, -80)
sendPage.Position = UDim2.new(0, 0, 0, 80)
sendPage.BackgroundTransparency = 1
sendPage.Visible = true
sendPage.Parent = mainFrame

local function createInputField(labelText, placeholderText, yPos)
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0.9, 0, 0, 16)
	label.Position = UDim2.new(0.05, 0, 0, yPos)
	label.BackgroundTransparency = 1
	label.Text = labelText
	label.TextColor3 = Color3.fromRGB(160, 160, 160)
	label.TextSize = 11
	label.Font = Enum.Font.GothamBold
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = sendPage

	local box = Instance.new("TextBox")
	box.Size = UDim2.new(0.9, 0, 0, 32)
	box.Position = UDim2.new(0.05, 0, 0, yPos + 16)
	box.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
	box.BorderSizePixel = 0
	box.PlaceholderText = placeholderText
	box.Text = ""
	box.TextColor3 = Color3.fromRGB(255, 190, 0)
	box.TextSize = 12
	box.Font = Enum.Font.GothamMedium
	box.Parent = sendPage

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = box

	return box
end

local recipientInput = createInputField("Recipient Username", "Username", 0)
local selectedItemInput = createInputField("Selected Item Name", "Click an item below", 54)
local quantityInput = createInputField("Quantity", "1", 108)

-- Dropdown Category
local dropLabel = Instance.new("TextLabel")
dropLabel.Size = UDim2.new(0.9, 0, 0, 16)
dropLabel.Position = UDim2.new(0.05, 0, 0, 162)
dropLabel.BackgroundTransparency = 1
dropLabel.Text = "Category Select"
dropLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
dropLabel.TextSize = 11
dropLabel.Font = Enum.Font.GothamBold
dropLabel.TextXAlignment = Enum.TextXAlignment.Left
dropLabel.Parent = sendPage

local dropdownBtn = Instance.new("TextButton")
dropdownBtn.Size = UDim2.new(0.9, 0, 0, 30)
dropdownBtn.Position = UDim2.new(0.05, 0, 0, 178)
dropdownBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
dropdownBtn.Text = "🐾 Pets  ▼"
dropdownBtn.TextColor3 = Color3.fromRGB(255, 190, 0)
dropdownBtn.TextSize = 12
dropdownBtn.Font = Enum.Font.GothamMedium
dropdownBtn.Parent = sendPage

local dropCorner = Instance.new("UICorner")
dropCorner.CornerRadius = UDim.new(0, 6)
dropCorner.Parent = dropdownBtn

local dropdownList = Instance.new("Frame")
dropdownList.Size = UDim2.new(0.9, 0, 0, 128)
dropdownList.Position = UDim2.new(0.05, 0, 0, 212)
dropdownList.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
dropdownList.BorderSizePixel = 0
dropdownList.Visible = false
dropdownList.ZIndex = 10
dropdownList.Parent = sendPage

local listCorner = Instance.new("UICorner")
listCorner.CornerRadius = UDim.new(0, 6)
listCorner.Parent = dropdownList

local listLayout = Instance.new("UIListLayout")
listLayout.Parent = dropdownList

-- Scrollable Item Display Box
local itemDisplayFrame = Instance.new("ScrollingFrame")
itemDisplayFrame.Size = UDim2.new(0.9, 0, 0.22, 0)
itemDisplayFrame.Position = UDim2.new(0.05, 0, 0, 214)
itemDisplayFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
itemDisplayFrame.BorderSizePixel = 0
itemDisplayFrame.ScrollBarThickness = 4
itemDisplayFrame.Parent = sendPage

local itemGrid = Instance.new("UIGridLayout")
itemGrid.CellSize = UDim2.new(0.47, 0, 0, 30)
itemGrid.CellPadding = UDim2.new(0.04, 0, 0, 5)
itemGrid.Parent = itemDisplayFrame

local itemCorner = Instance.new("UICorner")
itemCorner.CornerRadius = UDim.new(0, 6)
itemCorner.Parent = itemDisplayFrame

local selectedCategory = "Pets"
local lastSelectedBtn = nil

local function refreshItemList(category)
	for _, child in ipairs(itemDisplayFrame:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end

	for _, item in ipairs(ItemDatabase) do
		if item.category == category then
			local btn = Instance.new("TextButton")
			btn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
			btn.Text = (item.icon or "🔹") .. " " .. item.name
			btn.TextColor3 = Color3.fromRGB(230, 230, 230)
			btn.TextSize = 10
			btn.Font = Enum.Font.Gotham
			btn.TextTruncate = Enum.TextTruncate.AtEnd
			btn.Parent = itemDisplayFrame

			local cCorner = Instance.new("UICorner")
			cCorner.CornerRadius = UDim.new(0, 4)
			cCorner.Parent = btn

			local stroke = Instance.new("UIStroke")
			stroke.Color = Color3.fromRGB(255, 190, 0)
			stroke.Thickness = 1.5
			stroke.Enabled = false
			stroke.Parent = btn

			-- Smooth item selection highlight
			btn.MouseButton1Click:Connect(function()
				if lastSelectedBtn and lastSelectedBtn:FindFirstChild("UIStroke") then
					lastSelectedBtn.UIStroke.Enabled = false
					lastSelectedBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
				end

				stroke.Enabled = true
				btn.BackgroundColor3 = Color3.fromRGB(45, 40, 20)
				lastSelectedBtn = btn

				selectedItemInput.Text = item.name
			end)
		end
	end
	itemDisplayFrame.CanvasSize = UDim2.new(0, 0, 0, itemGrid.AbsoluteContentSize.Y)
end

local categories = {
	{Name = "Pets", Icon = "🐾"},
	{Name = "Seeds", Icon = "🌱"},
	{Name = "Sprinklers", Icon = "💦"},
	{Name = "WateringCans", Icon = "🚿"}
}

for _, cat in ipairs(categories) do
	local optionBtn = Instance.new("TextButton")
	optionBtn.Size = UDim2.new(1, 0, 0, 32)
	optionBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
	optionBtn.Text = cat.Icon .. " " .. cat.Name
	optionBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
	optionBtn.TextSize = 12
	optionBtn.Font = Enum.Font.GothamMedium
	optionBtn.ZIndex = 11
	optionBtn.Parent = dropdownList

	optionBtn.MouseButton1Click:Connect(function()
		selectedCategory = cat.Name
		dropdownBtn.Text = cat.Icon .. " " .. cat.Name .. "  ▼"
		dropdownList.Visible = false
		refreshItemList(selectedCategory)
	end)
end

dropdownBtn.MouseButton1Click:Connect(function()
	dropdownList.Visible = not dropdownList.Visible
end)

refreshItemList(selectedCategory)

local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(0.9, 0, 0, 38)
submitBtn.Position = UDim2.new(0.05, 0, 1, -48)
submitBtn.BackgroundColor3 = Color3.fromRGB(255, 190, 0)
submitBtn.Text = "SEND MAIL"
submitBtn.TextColor3 = Color3.fromRGB(20, 20, 20)
submitBtn.TextSize = 13
submitBtn.Font = Enum.Font.GothamBold
submitBtn.Parent = sendPage

local submitCorner = Instance.new("UICorner")
submitCorner.CornerRadius = UDim.new(0, 6)
submitCorner.Parent = submitBtn

----------------------------------------------------
-- TAB 2: HISTORY LOG PAGE
----------------------------------------------------
local historyPage = Instance.new("Frame")
historyPage.Name = "HistoryPage"
historyPage.Size = UDim2.new(1, 0, 1, -80)
historyPage.Position = UDim2.new(0, 0, 0, 80)
historyPage.BackgroundTransparency = 1
historyPage.Visible = false
historyPage.Parent = mainFrame

local logScrollFrame = Instance.new("ScrollingFrame")
logScrollFrame.Size = UDim2.new(0.9, 0, 0.85, 0)
logScrollFrame.Position = UDim2.new(0.05, 0, 0, 0)
logScrollFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
logScrollFrame.BorderSizePixel = 0
logScrollFrame.ScrollBarThickness = 4
logScrollFrame.Parent = historyPage

local logScrollCorner = Instance.new("UICorner")
logScrollCorner.CornerRadius = UDim.new(0, 6)
logScrollCorner.Parent = logScrollFrame

local logLayout = Instance.new("UIListLayout")
logLayout.Padding = UDim.new(0, 6)
logLayout.SortOrder = Enum.SortOrder.LayoutOrder
logLayout.Parent = logScrollFrame

local emptyLogText = Instance.new("TextLabel")
emptyLogText.Size = UDim2.new(1, 0, 1, 0)
emptyLogText.BackgroundTransparency = 1
emptyLogText.Text = "No mail history recorded yet."
emptyLogText.TextColor3 = Color3.fromRGB(120, 120, 120)
emptyLogText.TextSize = 12
emptyLogText.Font = Enum.Font.GothamMedium
emptyLogText.Parent = logScrollFrame

local clearLogBtn = Instance.new("TextButton")
clearLogBtn.Size = UDim2.new(0.9, 0, 0, 32)
clearLogBtn.Position = UDim2.new(0.05, 0, 1, -38)
clearLogBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
clearLogBtn.Text = "🗑️ Clear History"
clearLogBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
clearLogBtn.TextSize = 11
clearLogBtn.Font = Enum.Font.GothamBold
clearLogBtn.Parent = historyPage

local clearCorner = Instance.new("UICorner")
clearCorner.CornerRadius = UDim.new(0, 6)
clearCorner.Parent = clearLogBtn

----------------------------------------------------
-- LOG SYSTEM LOGIC
----------------------------------------------------
local logCount = 0

local function addHistoryEntry(recipient, itemName, quantity)
	emptyLogText.Visible = false
	logCount = logCount + 1

	local currentTime = os.date("%X")

	local card = Instance.new("Frame")
	card.Size = UDim2.new(1, -8, 0, 48)
	card.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
	card.BorderSizePixel = 0
	card.LayoutOrder = -logCount
	card.Parent = logScrollFrame

	local cardCorner = Instance.new("UICorner")
	cardCorner.CornerRadius = UDim.new(0, 6)
	cardCorner.Parent = card

	local logTitle = Instance.new("TextLabel")
	logTitle.Size = UDim2.new(1, -12, 0, 20)
	logTitle.Position = UDim2.new(0, 8, 0, 4)
	logTitle.BackgroundTransparency = 1
	logTitle.Text = "<b>To:</b> " .. recipient .. " | <b>Item:</b> " .. itemName
	logTitle.TextColor3 = Color3.fromRGB(255, 190, 0)
	logTitle.TextSize = 11
	logTitle.RichText = true
	logTitle.Font = Enum.Font.Gotham
	logTitle.TextXAlignment = Enum.TextXAlignment.Left
	logTitle.Parent = card

	local logSub = Instance.new("TextLabel")
	logSub.Size = UDim2.new(1, -12, 0, 18)
	logSub.Position = UDim2.new(0, 8, 0, 24)
	logSub.BackgroundTransparency = 1
	logSub.Text = "<b>Qty:</b> " .. quantity .. "  •  <b>Time:</b> " .. currentTime
	logSub.TextColor3 = Color3.fromRGB(160, 160, 160)
	logSub.TextSize = 10
	logSub.RichText = true
	logSub.Font = Enum.Font.Gotham
	logSub.TextXAlignment = Enum.TextXAlignment.Left
	logSub.Parent = card

	logScrollFrame.CanvasSize = UDim2.new(0, 0, 0, logLayout.AbsoluteContentSize.Y + 10)
end

clearLogBtn.MouseButton1Click:Connect(function()
	for _, child in ipairs(logScrollFrame:GetChildren()) do
		if child:IsA("Frame") then
			child:Destroy()
		end
	end
	emptyLogText.Visible = true
	logScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
end)

----------------------------------------------------
-- NAVIGATION TABS SWITCHING
----------------------------------------------------
sendTabBtn.MouseButton1Click:Connect(function()
	sendPage.Visible = true
	historyPage.Visible = false

	sendTabBtn.BackgroundColor3 = Color3.fromRGB(255, 190, 0)
	sendTabBtn.TextColor3 = Color3.fromRGB(20, 20, 20)

	historyTabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	historyTabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
end)

historyTabBtn.MouseButton1Click:Connect(function()
	sendPage.Visible = false
	historyPage.Visible = true

	historyTabBtn.BackgroundColor3 = Color3.fromRGB(255, 190, 0)
	historyTabBtn.TextColor3 = Color3.fromRGB(20, 20, 20)

	sendTabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	sendTabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
end)

----------------------------------------------------
-- SUBMIT BUTTON ACTION
----------------------------------------------------
submitBtn.MouseButton1Click:Connect(function()
	local recipient = recipientInput.Text
	local itemName = selectedItemInput.Text
	local quantity = quantityInput.Text == "" and "1" or quantityInput.Text

	if recipient == "" or itemName == "" then
		warn("Please provide both Recipient Username and Item Name!")
		return
	end

	addHistoryEntry(recipient, itemName, quantity)

	print("--- MAIL SENT ---")
	print("Recipient:", recipient)
	print("Item:", itemName)
	print("Quantity:", quantity)
end)

----------------------------------------------------
-- OPEN / CLOSE TOGGLE CONTROLS
----------------------------------------------------
local isMinimized = false

local function toggleUI()
	mainFrame.Visible = not mainFrame.Visible
end

toggleBtn.MouseButton1Click:Connect(toggleUI)

closeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
end)

minimizeBtn.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	sendPage.Visible = not isMinimized and (sendTabBtn.BackgroundColor3 == Color3.fromRGB(255, 190, 0))
	historyPage.Visible = not isMinimized and (historyTabBtn.BackgroundColor3 == Color3.fromRGB(255, 190, 0))
	navBar.Visible = not isMinimized

	if isMinimized then
		mainFrame.Size = UDim2.new(0.9, 0, 0, 36)
		minimizeBtn.Text = "➕"
	else
		mainFrame.Size = UDim2.new(0.9, 0, 0.85, 0)
		minimizeBtn.Text = "➖"
	end
end)
