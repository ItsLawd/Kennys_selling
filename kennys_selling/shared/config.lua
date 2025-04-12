Config = {}

Config.SellKey = 30 -- E

Config.Drugs = {
    item1 = { -- change "item1" to the item for | Example down below
        label = '', -- Item name
        price = { min = 50, max = 200 }, -- Min & Max the user can be paid for
        rewardItem = 'black_money', -- the item they would recive for selling the item | pre set to black_money
        bags = { min = 1, max = 3 } -- Optional: specify the number of bags to sell
    },
    --[EXAMPLE DRUG]--
    meth = {
        label = 'meth',
        price = { min = 250, max = 450 },
        rewardItem = 'black_money',
        bags = { min = 1, max = 3 }
    }
}

Config.NPCResellCooldown = 3 -- this means the player can not sell to the NPC for 3 times in a row. After that, the player can sell again to the same NPC.

Config.SellDuration = 3000   -- 3 seconds in ms, this is the bar for selling.

--[NOTE]--

-- Please, not there may be some bugs with this script, i am going to update this with an enable option for having the bar or circle or none.
-- I am going to be adding more features to this in due time, feel free to edit and change this. Please issue them as pulls or create an issue for me to add to this
