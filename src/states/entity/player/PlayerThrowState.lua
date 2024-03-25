--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerThrowState = Class { __includes = EntityIdleState }

function PlayerThrowState:enter(params)
    self.entity:changeAnimation('throw-' .. self.entity.direction)
    self.pot = params.pot
    gSounds['throw']:play()
end

function PlayerThrowState:update(dt)
    if self.entity.currentAnimation.currentFrame == 2 then
        local newX
        local newY
        if self.entity.direction == 'left' then
            newX = self.pot.x - TILE_SIZE * 4
            newY = self.pot.y
        elseif self.entity.direction == 'right' then
            newX = self.pot.x + TILE_SIZE * 4
            newY = self.pot.y
        elseif self.entity.direction == 'up' then
            newX = self.pot.x
            newY = self.pot.y - TILE_SIZE * 4
        elseif self.entity.direction == 'down' then
            newX = self.pot.x
            newY = self.pot.y + TILE_SIZE * 4
        end
        Timer.tween(.5, {
            [self.pot] = { x = newX, y = newY }
        })
        Timer.after(.5, function()
            if not self.pot.hitWall then
                self.pot.destroyed = true
            end
        end)
    end
    if self.entity.currentAnimation.currentFrame >= #self.entity.currentAnimation.frames then
        self.pot.thrown = true
        self.entity.currentAnimation:refresh()
        self.entity:changeState('idle')
    end
end
