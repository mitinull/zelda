--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerLiftState = Class { __includes = EntityIdleState }

function PlayerLiftState:enter(params)
    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 5
    self.entity.offsetX = 0
    self.entity:changeAnimation('lift-' .. self.entity.direction)
    self.pot = params.pot
end

function PlayerLiftState:update(dt)
    if self.entity.currentAnimation.currentFrame >= #self.entity.currentAnimation.frames then
        self.pot.solid = false
        self.pot.pickedUp = true
        self.pot.x = self.entity.x
        self.pot.y = self.entity.y - 8
        self.entity.currentAnimation:refresh()
        self.entity:changeState('pot-idle', { pot = self.pot })
    end
end
