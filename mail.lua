-- LocalScript
-- Location: Place directly inside your Mail Frame (ScreenGui > MailFrame)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

-- ==========================================
-- UI REFERENCES
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
local sendMailEvent = ReplicatedStorage:WaitForChild("SendMailEvent") :: RemoteEvent

-- ==========================================
-- STATE VARIABLES
-- ==========================================
local selectedItemId = nil
local totalSendsCount = 0
local isProcessing = false

-- ==========================================
-- FUNCTIONS
-- ==========================================

local function setStatus(message: string, isError: boolean)
	statusLabel.Text = message
	if isError then
		statusLabel.TextColor3 = Color3.fromRGB(255, 75, 75)
	else
		statusLabel.TextColor3 = Color3.fromRGB(75, 255, 125)
	end
end

local function updateTotalSendsDisplay()
	totalSendsLabel.Text = "Total Sent: " .. tostring(totalSendsCount)
end

local function onSelectItem(itemId: string)
	selectedItemId = itemId
	itemSelectButton.Text = "Selected: " .. itemId
	setStatus("Item selected.", false)
end

local function onSendClicked()
	if isProcessing then return end

	local recipientName = string.gsub(recipientInput.Text, "^%s*(.-)%s*$", "%1")

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

	isProcessing = true
	sendButton.Interactable = false
	setStatus("Sending mail...", false)

	sendMailEvent:FireServer(recipientName, selectedItemId)
end

local function onServerResponse(success: boolean, responseMessage: string, newTotalSends: number?)
	isProcessing = false
	sendButton.Interactable = true

	setStatus(responseMessage, not success)

	if success then
		totalSendsCount = newTotalSends or (totalSendsCount + 1)
		updateTotalSendsDisplay()

		selectedItemId = nil
		itemSelectButton.Text = "Select Item"
		recipientInput.Text = ""
	end
end

-- ==========================================
-- INITIALIZATION & CONNECTIONS
-- ==========================================

updateTotalSendsDisplay()
setStatus("Ready", false)

sendButton.MouseButton1Click:Connect(onSendClicked)
sendMailEvent.OnClientEvent:Connect(onServerResponse)

-- Placeholder item selector connection
itemSelectButton.MouseButton1Click:Connect(function()
	onSelectItem("SampleItem_01")
end)
