Config = {}

Config.SellKey = 30 -- E

Config.Drugs = {
    weed = {
        label = 'weed_brick',
        price = { min = 50, max = 200 },
        rewardItem = 'black_money',
        bags = { min = 1, max = 3 } -- Optional: specify the number of bags to sell
    },
    meth = {
        label = 'meth',
        price = { min = 250, max = 450 },
        rewardItem = 'black_money',
        bags = { min = 1, max = 3 }
    }
}

Config.NPCResellCooldown = 1 -- this means, the player can not sell to the NPC for 3 times in a row. After that, the player can sell again to the same NPC.

Config.SellDuration = 3000   -- 3 seconds
