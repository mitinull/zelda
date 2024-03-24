--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerPotIdleState = Class { __includes = EntityIdleState }

function PlayerPotIdleState:enter(params)
    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 5
    self.entity.offsetX = 0
    self.entity:changeAnimation('idle-pot-' .. self.entity.direction)
    self.pot = params.pot
end

function PlayerPotIdleState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
        love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        self.entity:changeState('pot-walk', { pot = self.pot })
    end

    if love.keyboard.wasPressed('space') then
        self.entity:changeState('throw', { pot = self.pot })
    end
end
