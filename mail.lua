-- LocalScript
-- Location: Place directly inside the main Mail Frame (ScreenGui > MailFrame)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

-- ==========================================
-- UI REFERENCES
-- (Ensure these object names match your GUI hierarchy)
-- ==========================================
local mainFrame = script.Parent
local recipientInput = mainFrame:WaitForChild("RecipientInput") :: TextBox
local itemSelectButton = mainFrame:WaitForChild("ItemSelectButton") :: TextButton
local sendButton = mainFrame:WaitForChild("SendButton") :: TextButton
local statusLabel = mainFrame:WaitForChild("StatusLabel") :: TextLabel
local totalSendsLabel = mainFrame:WaitForChild("TotalSendsLabel") :: TextLabel

-- ==========================================
-- NETWORKING
-- ==========================================
-- RemoteEvent placed in ReplicatedStorage for server communication
local sendMailEvent = ReplicatedStorage:WaitForChild("SendMailEvent") :: RemoteEvent

-- ==========================================
-- STATE VARIABLES
-- ==========================================
local selectedItemId = nil
local totalSendsCount = 0
local isProcessing = false

-- ==========================================
-- HELPER FUNCTIONS
-- ==========================================

-- Updates the status text and optional color
local function setStatus(message: string, isError: boolean)
	statusLabel.Text = message
	if isError then
		statusLabel.TextColor3 = Color3.fromRGB(255, 75, 75)
	else
		statusLabel.TextColor3 = Color3.fromRGB(75, 255, 125)
	end
end

-- Refreshes the total send count UI text
local function updateTotalSendsDisplay()
	totalSendsLabel.Text = "Total Sent: " .. tostring(totalSendsCount)
end

-- ==========================================
-- EVENT HANDLERS
-- ==========================================

-- Example selection function (Call this when an item in your inventory grid is clicked)
local function onSelectItem(itemId: string)
	selectedItemId = itemId
	itemSelectButton.Text = "Selected: " .. itemId
	setStatus("Item selected.", false)
end

-- Main send handler
local function onSendClicked()
	if isProcessing then return end

	local rawRecipientText = recipientInput.Text
	-- Trim whitespace
	local recipientName = string.gsub(rawRecipientText, "^%s*(.-)%s*$", "%1")

	-- Client-side validation checks
	if recipientName == "" then
		setStatus("Please enter a recipient username.", true)
		return
	end

	if not selectedItemId then
		setStatus("Please select an item to send.", true)
		return
	end

	if recipientName:lower() == LocalPlayer.Name:lower() then
		setStatus("You cannot send items to yourself.", true)
		return
	end

	-- Lock UI controls during the network request
	isProcessing = true
	sendButton.Interactable = false
	setStatus("Sending mail...", false)

	-- Fire request to the server
	sendMailEvent:FireServer(recipientName, selectedItemId)
end

-- Handle responses returning from the server
local function onServerResponse(success: boolean, responseMessage: string, newTotalSends: number?)
	-- Unlock UI controls
	isProcessing = false
	sendButton.Interactable = true

	-- Display server response status
	setStatus(responseMessage, not success)

	-- Update counter if transaction succeeded
	if success then
		if newTotalSends then
			totalSendsCount = newTotalSends
		else
			totalSendsCount += 1
		end
		updateTotalSendsDisplay()

		-- Clear selection reset
		selectedItemId = nil
		itemSelectButton.Text = "Select Item"
		recipientInput.Text = ""
	end
end

-- ==========================================
-- INITIALIZATION & BINDINGS
-- ==========================================

-- Initialize display
updateTotalSendsDisplay()
setStatus("Ready", false)

-- Bind UI actions
sendButton.MouseButton1Click:Connect(onSendClicked)
sendMailEvent.OnClientEvent:Connect(onServerResponse)

-- Example item selection binding (Connect your inventory UI slots to this)
itemSelectButton.MouseButton1Click:Connect(function()
	-- Temporary placeholder for selection logic
	onSelectItem("Sample_Seed_Item")
end)
